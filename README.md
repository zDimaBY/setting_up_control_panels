**Script for displaying information about the system**
Autorun for MobaXterm:
```bash
[ ! -f ~/.vimrc ] && echo -e "set number\nsyntax on" > ~/.vimrc && trap 'rm ~/.vimrc' EXIT && echo "Settings applied for the current session." || echo "File .vimrc already exists, no changes made."; (command -v curl &> /dev/null && curl -sSL https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash) || (command -v wget &> /dev/null && wget -qO- https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash) || { echo "Error: Neither 'curl' nor 'wget' found. Please install one of them to continue."; exit 1; }
```

Run in terminal:
```bash
curl -sSL https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash
```
or
```bash
wget -qO- https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash
```

**Control Panel Commands:**
Розгортання скрипта:
```bash
wget -N https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/setting_up_control_panels.sh && bash ./setting_up_control_panels.sh && history -c && history -a
```

Після завершення роботи використовуйте цю команду:
```bash
rm -rf /root/scripts_* /root/setting_up_control_panels.sh && history -c && history -a
```

### Supported panel operating systems

| Operating System | Version | Supported          |
| ---------------- | ------- | ------------------ |
| SystemRescueCD   | 9.06    | :yellow_circle:    |
|                  | 11.00   | :yellow_circle:    |
| Ubuntu           | 18.04   | :yellow_circle:    |
|                  | 20.04   | :green_circle:     |
|                  | 22.04   | :green_circle:     |
|                  | 24.04   | :green_circle:     |
| Debian           | 10      | :yellow_circle:    |
|                  | 11      | :yellow_circle:    |
|                  | 12      | :yellow_circle:    |
| CentOS Stream    | 8       | :yellow_circle:    |
|                  | 9       | :yellow_circle:    |
| AlmaLinux        | 8       | :red_circle:       |
|                  | 9       | :red_circle:       |
| Rocky-Linux      | 8       | :red_circle:       |
|                  | 9       | :red_circle:       |