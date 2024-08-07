![GitHub stars](https://img.shields.io/github/stars/zDimaBY/open_auto_install_scripts?style=social)
![GitHub forks](https://img.shields.io/github/forks/zDimaBY/open_auto_install_scripts?style=social)
![GitHub issues](https://img.shields.io/github/issues/zDimaBY/open_auto_install_scripts)
![GitHub license](https://img.shields.io/github/license/zDimaBY/open_auto_install_scripts)
![GitHub last commit](https://img.shields.io/github/last-commit/zDimaBY/open_auto_install_scripts)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FzDimaBY%2Fopen_auto_install_scripts&count_bg=%230097B4&title_bg=%23492460&icon=abbrobotstudio.svg&icon_color=%23E7E7E7&title=visits+day+%2F+total&edge_flat=false)](https://hits.seeyoufarm.com)

<strong><span style="color: gold;">Control Panel Commands:</span></strong><br>
Deploy the Script
<span style="color: green;">Use the following command to download and run the setup script:</span>
```bash
wget -N https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/open_auto_install_scripts.sh && bash ./open_auto_install_scripts.sh && history -c && history -a
```

<strong>Script for displaying information about the system</strong><br>
Autorun for MobaXterm:<br>
```bash
(command -v curl &> /dev/null && curl -sSL https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/linuxinfo.sh | bash) || (command -v wget &> /dev/null && wget -qO- https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/linuxinfo.sh | bash) || { echo "Error: Neither 'curl' nor 'wget' found. Please install one of them to continue."; exit 1; }
```
or<br>
```bash
[ ! -f ~/.vimrc ] && echo -e "set number\nsyntax on" > ~/.vimrc && trap 'rm ~/.vimrc' EXIT && echo "Settings applied for the current session." || echo "File .vimrc already exists, no changes made."; (command -v curl &> /dev/null && curl -sSL --max-time 2 -s https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/linuxinfo.sh | bash) || (command -v wget &> /dev/null && wget --timeout=2 -qO- https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/linuxinfo.sh | bash) || { echo "Error: Neither 'curl' nor 'wget' found. Please install one of them to continue."; exit 1; }
```

Run in terminal:<br>
<code>curl -sSL https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/linuxinfo.sh | bash</code><br>
or<br>
<code>wget -qO- https://raw.githubusercontent.com/zDimaBY/open_auto_install_scripts/main/linuxinfo.sh | bash</code><br>

### Supported panel operating systems
| Operating System | Version | Supported          |
| ---------------- | ------- | ------------------ |
| SystemRescueCD   | 9.06    | :yellow_circle:    |
|                  | 11.00   | :yellow_circle:    |
| Ubuntu           | 18.04   | :yellow_circle:    |
|                  | 20.04   | :green_circle:     |
|                  | 22.04   | :green_circle:     |
|                  | 24.04   | :green_circle:     |
| Debian           | 10      | :green_circle:     |
|                  | 11      | :green_circle:     |
|                  | 12      | :green_circle:     |
| CentOS Stream    | 8       | :yellow_circle:    |
|                  | 9       | :yellow_circle:    |
| Rocky-Linux      | 8       | :red_circle:       |
|                  | 9       | :red_circle:       |
