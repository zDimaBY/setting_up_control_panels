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
| Ubuntu           | 18.04   | :yellow_circle:    |
|                  | 20.04   | :green_circle:     |
|                  | 22.04   | :green_circle:     |
| Debian           | 10      | :yellow_circle:    |
|                  | 11      | :yellow_circle:    |
|                  | 12      | :red_circle:       |
| CentOS           | 7       | :yellow_circle:    |
|                  | 8       | :yellow_circle:    |
| SystemRescueCD   | 9.06    | :red_circle:       |
|                  | 11.00   | :red_circle:       |