#!/usr/bin/bash

#A simple script to notify me on connection speed in case the connection status changes.

NAME=$1
ACTION=$2

if [[ "$ACTION" == "up" ]]; then
        echo "Connection_Notifier - Program activated by Network Manager"
        wget -q --spider https://google.com

        if [[ $? -eq 0 ]]; then
            echo "Connection_Notifier - wget result: Online"
            echo "Connection_Notifier - running speedtest..."
            spd_results=$(speedtest --secure)
            echo "Connection_Notifier - speedtest results: $spd_results"
            provider=$(grep -E -w -o "Testing from ([[:alnum:]]*[[:space:]]*[[:alnum:]]*[[:space:]]*[[:alnum:]]*) " <<< $spd_results)
            provider=${provider:13:-1}
            download=$(grep -E -w -o "Download: ([[:digit:]]{0,3}).([[:digit:]]{2}) Mbit/s" <<< $spd_results)
            download=${download:10}
            upload=$(grep -E -w -o "Upload: ([[:digit:]]{0,3}).([[:digit:]]{2}) Mbit/s" <<< $spd_results)
            upload=${upload:8}

            if [[ $download == "" ]]; then
                sudo -u andrealonghi DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --hint int:transient:1 -a "Connection Notifier" -t 6000 -i network-receive "✅ ONLINE" "The speedtest couldn't get data, sorry..."
                echo "Connection_Notifier - Program executed successfully"
            else
                sudo -u andrealonghi DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -a "Connection Notifier" -t 6000 -i network-receive "✅ ONLINE with $provider" "⏬  <b>$download</b>  ⏫  <b>$upload</b>"
                echo "Connection_Notifier - Program executed successfully"
            fi

        else
            echo "Connection_Notifier - wget result: Error on Connection"
            sudo -u andrealonghi DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --hint int:transient:1 -a "Connection Notifier" -t 6000 -i network-offline "⛔ Connection Status: OFFLINE" "If you tried everything you can always open a bar..."
            echo "Connection_Notifier - Program executed successfully"
        fi

elif [[ "$ACTION" == "down" ]]; then
        echo "Connection_Notifier - wget result: Offline"
        sudo -u andrealonghi DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --hint int:transient:1 -a "Connection Notifier" -t 6000 -i network-offline "⛔ Connection Status: OFFLINE" "...It's good to be offline sometimes..."
        echo "Connection_Notifier - Program executed successfully"
fi