# shellcheck disable=SC2148
# shellcheck disable=SC2154
function 2_site_control_panel() {
    while true; do
        checkControlPanel
        echo -e "\nВиберіть дію:\n"
        echo -e "1. Встановлення/апгрейд ${RED}ioncube${RESET} для всіх php версії (Hestiacp + php-fpm) ${RED}(test)${RESET}"
        echo -e "2. Встановлення ${RED}CMS${RESET} ${RED}(test)${RESET}"
        echo -e "\n0. Вийти з цього підменю!"
        echo -e "00. Закінчити роботу скрипта\n"

        read -p "Виберіть варіант:" choice

        case $choice in
        1) 2_updateIoncube ;;
        2) 2_install_list_CMS ;;
        0) break ;;
        00) 0_funExit ;;
        *) 0_invalid ;;
        esac
    done
}

function 2_updateIoncube() {
    # Instals Ioncube on all  existing and supported php versions
    if [ -f "/etc/hestiacp/hestia.conf" ]; then
        source /etc/hestiacp/hestia.conf
    else
        echo "Помилка: Файл /etc/hestiacp/hestia.conf не знайдено"
    fi

    # Look up what version is used x86_64 needs to become x86-64 instead
    # Only tested for aarch and x86_64
    arc=$(arch)
    if [ "$arc" = "x86_64" ]; then
        arc="x86-64"
    fi

    # Download url
    url="https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$arc.tar.gz"
    wget "$url" -O - | tar -xz

    for php_version in $("$HESTIA"/bin/v-list-sys-php plain); do
        # Check if ioncube version is supported for example 8.0 is not availble!
        if [ ! -f "./ioncube/ioncube_loader_lin_$php_version.so" ]; then
            echo "PHP$php_version наразі не підтримується Ioncube"
            continue
        fi
        # Get extension dir and don't depend on user input
        extension_dir=$(/usr/bin/php"$php_version" -i | grep extension_dir | cut -d' ' -f5)

        # Copy ioncube file to extension dir
        cp ./ioncube/ioncube_loader_lin_"$php_version"* "$extension_dir"
        echo "Ioncube встановлена для PHP$php_version"
        # Add to conf.d folder for php-fpm and cli
        echo "zend_extension=ioncube_loader_lin_$php_version.so" >/etc/php/"$php_version"/fpm/conf.d/00-ioncube-loader.ini
        echo "zend_extension=ioncube_loader_lin_$php_version.so" >/etc/php/"$php_version"/cli/conf.d/00-ioncube-loader.ini
    done

    "$HESTIA"/bin/v-restart-service 'php-fpm' yes
    #clean up the trash
    rm -fr ioncube
}

2_install_list_CMS() {
    #Перевіряємо сумісніть системи
    case $operating_system in
    debian | ubuntu)
        echo -e "${RED}$operating_system ...${RESET}"
        ;;
    fedora)
        echo -e "${RED}$operating_system ...${RESET}"
        ;;
    centos | oracle)
        echo -e "${RED}$operating_system ...${RESET}"
        ;;
    arch)
        echo -e "${RED}$operating_system ...${RESET}"
        ;;
    *)
        echo -e "${RED}Не вдалося визначити систему.${RESET}"
        return 1
        ;;
    esac

    #Перевіряємо яка панель керування встановлена
    if [ -e "/usr/local/vesta" ]; then
        echo -e "${YELLOW}Використовується VestaCP.${RESET}"
        source /etc/profile
        source $VESTA/func/main.sh
        source $VESTA/conf/vesta.conf
    elif [ -e "/usr/local/hestia" ]; then
        echo -e "${YELLOW}Використовується HestiaCP.${RESET}"
        source /etc/profile
        source $HESTIA/func/main.sh
        source $HESTIA/conf/hestia.conf
    else
        echo -e "${RED}Не вдалося визначити панель управління сайтами.${RESET}"
        exit 1
    fi
    
    # Шлях до директорії з користувачами
    user_dir="/usr/local/hestia/data/users/"

    # Виведення списку папок
    echo "Доступні користувачі панелі керування сайтами:"
    folders=($(find "$user_dir" -maxdepth 1 -mindepth 1 -type d -printf "%f\n"))

    # Перелік індексів папок
    for ((i = 0; i < ${#folders[@]}; i++)); do
        echo "$(($i + 1)). ${folders[$i]}"
    done

    # Запит на вибір папки
    read -p "Виберіть користувача панелі керування сайтами: " choice

    # Перевірка правильності вводу
    if [[ ! "$choice" =~ ^[0-9]+$ ]]; then
        echo "Будь ласка, виберіть користувача."
        exit 1
    fi

    # Перевірка чи номер вибраної папки в діапазоні
    if ((choice < 1 || choice > ${#folders[@]})); then
        echo "Недійсний номер папки."
        exit 1
    fi
    
    read -p "Вкажіть домен для wordpress: " WP_SITE_DOMEN
    
    SITE_PASSWORD=$(head /dev/urandom | tr -dc 'a-z' | head -c 12)
    SITE_ADMIN_MAIL="admin@$WP_SITE_DOMEN"

    WORDPRESS_URL="https://wordpress.org/latest.tar.gz"
    WP_USER="admin"
    rand_head=$(head /dev/urandom | tr -dc 'a-z' | head -c 6)
    DB_NAME="wp_db_$rand_head"
    rand_head=$(head /dev/urandom | tr -dc 'a-z' | head -c 6)
    DB_USER="wp_u_$rand_head"
    rand_head=$(head /dev/urandom | tr -dc 'a-z' | head -c 6)
    DB_PASSWORD="wp_p_$rand_head"
    HTACCESS_CONTENT="# BEGIN WordPress\n<IfModule mod_rewrite.c>\nRewriteEngine On\nRewriteBase /\nRewriteRule ^index\.php$ - [L]\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule . /index.php [L]\n</IfModule>\n# END WordPress"

    # Обрана папка
    CONTROLPANEL_USER="${folders[$((choice - 1))]}"
    echo "Ви обрали користувача: $CONTROLPANEL_USER"
    
    cd /home/$CONTROLPANEL_USER/web/$WP_SITE_DOMEN/public_html/

    # Завантажуємо та розпаковуємо WordPress
    echo -e "${YELLOW}Завантажуємо та розпаковуємо WordPress...${RESET}"
    wget $WORDPRESS_URL -O wordpress.tar.gz
    tar -xf wordpress.tar.gz
    mv wordpress/* .
    rmdir wordpress
    rm -rf latest.tar.gz

    # Налаштовуємо файл wp-config.php
    echo -e "${YELLOW}Налаштовуємо файл wp-config.php...${RESET}"
    cp wp-config-sample.php wp-config.php
    sed -i "s|database_name_here|${CONTROLPANEL_USER}_${DB_NAME}|" wp-config.php
    sed -i "s|username_here|${CONTROLPANEL_USER}_${DB_USER}|" wp-config.php
    sed -i "s|password_here|$DB_PASSWORD|" wp-config.php

    sed -i -e "/put your unique phrase here/{
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
    n;
    s|put your unique phrase here|$(openssl rand -base64 64 | tr -d '\n' | tr -d '\r')|;
}" wp-config.php

    # Створюємо .htaccess, якщо його немає
    if [ ! -e .htaccess ]; then
        echo $HTACCESS_CONTENT >.htaccess
        echo -e "${YELLOW}Створено файл .htaccess.${RESET}"
    else
        echo -e "${lIGHT_GREEN}Файл .htaccess вже існує.${RESET}"
    fi

    # Встановлюємо права доступу
    echo -e "${YELLOW}Встановлюємо права доступу...${RESET}"
    chown -R $CONTROLPANEL_USER:$CONTROLPANEL_USER *

    # Створюємо базу даних та користувача, якщо база даних не існує
    echo -e "${YELLOW}Створюємо базу даних та користувача...${RESET}"

    v-add-database $CONTROLPANEL_USER $DB_NAME $DB_USER $DB_PASSWORD

    # Перевірка наявності команди wp
    if ! command -v wp &>/dev/null; then
        echo -e "${RED}Команда 'wp' не знайдена. ${YELLOW}Встановлюємо WP-CLI...${RESET}"

        # Встановлюємо WP-CLI
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar
        mv wp-cli.phar /usr/local/bin/wp

        wp --allow-root --version
    fi

    wp core install --allow-root --url=http://${WP_SITE_DOMEN} --title=${WP_SITE_DOMEN} --admin_user=${WP_USER} --admin_password=${SITE_PASSWORD} --admin_email=${SITE_ADMIN_MAIL}

    wp language core install --allow-root --activate ru_RU

    #wp theme activate ваша_тема
    #wp plugin install назва_плагіна
    #wp plugin activate назва_плагіна

    echo -e "\n\n${lIGHT_GREEN}Wordpress встановлено: http://${WP_SITE_DOMEN}/wp-login.php${RESET}"
    echo -e "Логін: ${WP_USER}"
    echo -e "Пароль: ${SITE_PASSWORD}\n\n"

}