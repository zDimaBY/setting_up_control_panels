#!/bin/bash
# Autorun for MobaXterm:
# [ ! -f ~/.vimrc ] && echo -e "set number\nsyntax on" > ~/.vimrc && trap 'rm ~/.vimrc' EXIT && echo "Settings applied for the current session." || echo "File .vimrc already exists, no changes made."; (command -v curl &> /dev/null && curl -sSL --max-time 2 -s https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/linuxinfo.sh | bash) || (command -v wget &> /dev/null && wget --timeout=2 -qO- https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/linuxinfo.sh | bash) || { echo "Error: Neither 'curl' nor 'wget' found. Please install one of them to continue."; exit 1; }
# Run in terminal:
# curl -sSL https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/linuxinfo.sh | bash
# or
# wget -qO- https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/linuxinfo.sh | bash

# URL скрипта для завантаження
SCRIPT_URL="https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/functions_linux_info.sh"

# Функція для завантаження скрипта і виконання його
load_and_source_script() {
    local downloader="$1"
    local options="$2"
    if source <($downloader $options "$SCRIPT_URL"); then
        echo "Loaded script using $downloader."
    else
        echo "Failed to load script using $downloader."
        exit 1
    fi
}

# Перевірка наявності wget або curl
if command -v curl &>/dev/null; then
    load_and_source_script "curl" "--max-time 4 -s"
elif command -v wget &>/dev/null; then
    load_and_source_script "wget" "--timeout=4 -qO-"
else
    echo "Error: Neither 'wget' nor 'curl' found. Please install one of them to continue."
    exit 1
fi

check_compatibility_script # Функція перевірки суміснусті скрипта з сервером
distribute_ips
check_info_server "full" # Функція перевірки інформації про сервер
check_info_control_panel # Функція перевірки панелі керування
check_available_services # Функція перевірки наявних служб та портів
