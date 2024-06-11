<strong>Script for displaying information about the system</strong><br>
Autorun for MobaXterm:<br>
```bash
[ ! -f ~/.vimrc ] && echo -e "set number\nsyntax on" > ~/.vimrc && trap 'rm ~/.vimrc' EXIT && echo "Settings applied for the current session." || echo "File .vimrc already exists, no changes made."; (command -v curl &> /dev/null && curl -sSL https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash) || (command -v wget &> /dev/null && wget -qO- https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash) || { echo "Error: Neither 'curl' nor 'wget' found. Please install one of them to continue."; exit 1; }
```

Run in terminal:<br>
<code>curl -sSL https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash</code><br>
or<br>
<code>wget -qO- https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/scripts/linuxinfo.sh | bash</code><br>

<strong><span style="color: gold;">Control Panel Commands:</span></strong><br>
Deploy the Script
<span style="color: green;">Use the following command to download and run the setup script:</span>
```bash
wget -N https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/setting_up_control_panels.sh && bash ./setting_up_control_panels.sh && history -c && history -a
```

Cleanup After Execution
<span style="color: red;">After the script has completed its tasks, you can clean up by running:</span>
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
