#!/bin/sh

# Check if debugfs is mounted
if grep -qs 'debugfs' /proc/mounts; then
    echo "debugfs is mounted." >> /var/log/hdmi-event.log
else
    echo "debugfs is not mounted. Attempting to mount..." >> /var/log/hdmi-event.log
    mount -t debugfs debugfs /sys/kernel/debug
    if [ $? -eq 0 ]; then
        echo "debugfs successfully mounted." >> /var/log/hdmi-event.log
    else
        echo "Failed to mount debugfs." >> /var/log/hdmi-event.log
        exit 1
    fi
fi

# Path to the HDMI state file
hdmi_state_file="/sys/devices/platform/soc/6000000.hdmi/extcon/hdmi/state"

# Read the state
state=$(cat "$hdmi_state_file")

display="/sys/kernel/debug/dispdbg"

echo "$(date) - HDMI event triggered - ${state}" >> /var/log/hdmi-event.log

if [ "$state" == "HDMI=1" ]; then
        sed -i "s/audiocodec/ahubhdmi/g" /etc/asound.conf

	echo disp0 > $display/name
	echo switch1 > $display/command
	echo 4 10 0 0 0x4 0x101 0 0 0 8 > $display/param
	echo 1 > $display/start

	killall emulationstation
	fbset -g 1280 720 1280 1440 32

	echo "CONNECTED!"
else
        sed -i "s/ahubhdmi/audiocodec/g" /etc/asound.conf
        
	echo disp0 > $display/name
        echo switch > $display/command
        echo 1 0 > $display/param
        echo 1 > $display/start

	killall emulationstation
	fbset -g 640 480 640 960 32

	echo "HDMI DISCONNECTED!"
fi
