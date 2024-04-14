#!/bin/bash
# Коди кольорів
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
lIGHT_GREEN="\e[92m"
BROWN='\033[0;33m'
RESET="\e[0m"

# Каталог для скриптів
rand_head=$(head /dev/urandom | tr -dc 'a-z' | head -c 6)
folder_script_path="/root/scripts_${rand_head}"
mkdir -p "$folder_script_path"

urls=(
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/0_exit.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/1_list_install_programs.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/2_site_control_panel.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/4_DDos.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/5_VPN.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/6_FTP.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/7_MySQL.sh"
    "https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/functions_controller.sh"
)

# Завантаження та розгортання скриптів
for url in "${urls[@]}"; do
    filename=$(basename "$url")
    wget -qO "$folder_script_path/$filename" "$url" || { echo -e "${RED}Не вдалося завантажити $filename${RESET}"; exit 1; }
done

# Підключення усіх файлів з папки
for file in "$folder_script_path"/*; do
    if [[ -f "$file" && -r "$file" ]]; then
        source "$file" && rm -f "$file"
    fi
done
rm -rf "$folder_script_path" /root/setting_up_control_panels.sh

UPDATE_DONE=false
dependencies=(
    "grep grep"
    "sh dash"
    "awk gawk"
    "sed sed"
    "sort coreutils"
    "uniq coreutils"
    "cut coreutils"
    "iptables iptables"
    "timeout coreutils"
    "bc bc"
    "curl curl"
    "tail coreutils"
    "head coreutils"
    "basename coreutils"
    "jq jq"
)

for dependency in "${dependencies[@]}"; do
    check_dependency $dependency
done

#  ================= Start Script ==================
function selectionFunctions() {
    clear
    while true; do
        checkControlPanel
        echo -e "\nВиберіть дію:\n"
        echo -e "1. Встановлення ПЗ (${BROWN}Composer${RESET}, ${YELLOW}Docker${RESET}, ${BLUE}RouterOS 7.5${RESET}, ${BLUE}Elasticsearch${RESET})"
        echo -e "2. Функції для панелей керування сайтами ${RED}(test)${RESET}"
        echo -e "3. DDos"
        echo -e "4. Організування ${MAGENTA}VPN${RESET} серверів"
        echo -e "5. Організування ${BLUE}FTP${RESET} доступу ${RED}(test)${RESET}"
        echo -e "6. Організування ${MAGENTA}баз данних ${RED}(test)${RESET}"
        echo -e "0. Закінчити роботу скрипта\n"

        read -p "Виберіть варіант:" choice

        case $choice in
        1) 1_list_install_programs ;;
        2) 2_site_control_panel ;;
        3) 2_DDos ;;
        4) 3_VPN ;;
        5) 4_FTP ;;
        6) 5_DB ;;
        0) 0_funExit ;;
        *) 0_invalid ;;
        esac
    done
}

selectionFunctions
