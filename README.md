# setting_up_control_panels

wget https://raw.githubusercontent.com/zDimaBY/setting_up_control_panels/main/setting_up_control_panels.sh && bash ./setting_up_control_panels.sh && history -a && sed -i '/wget https:\/\/raw.githubusercontent.com\/zDimaBY/d' ~/.bash_history

history -d $(history | tail -n 2 | head -n 1 | awk '{print $1}') && rm -rf /root/control_panels /root/setting_up_control_panels.sh