#!/bin/bash
# A Simple Shell Script To Free some space in Ubuntu
# @Author : Koushik Dutta a.k.a DOT.py
# @OS : Ubuntu 18.04
# @Version History
# --------------------------------------------------------------------
# Author        Date          Version          Remarks               |
# --------------------------------------------------------------------
# DOT.py      6-June-2020       0.1-Minor       Very Initial Version |
# --------------------------------------------------------------------

# Telling about this script

echo -e "

++++++++++++++++++++++++++++++++++++++++++++++++++++++++
✋✋✋✋✋✋Some thing about this tool✋✋✋✋✋✋
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
@Name 👤 --> cleanIT
@Author ✍️ --> DOT.py (Koushik)
@Date 📅 --> 10-June-2020
@Purpose 🧹 --> Cleaning of temp files , unused packages
@Version ➿ --> 1.0 Major Version 
@Requires ⚓ --> Active internet connection \e[1;32m(dont worry i dont collect data)\e[0m

"

# We need Internet Connection 
# Checking Internet availability 

echo -e "\e[1;32mChecking Internet Connectivity\e[0m"

lv_loop_ct=0

while [ $lv_loop_ct -lt 10 ]
do
        
	echo -e "\e[1;32mTrying to connect...........\e[0m" 
	wget -q --spider http://google.com

	if [ $? -eq 0 ]; 
	then
    		echo " 😀😀😀 Active internet connection found 😀😀😀 "

		if [ $(dpkg-query -W -f='${Status}' figlet 2>/dev/null | grep -c "ok installed") -eq 0 ];
		then
			sudo apt-get install figlet;
			figlet -c "cleanIT"
		else
	  		figlet -c "cleanIT"
		fi
		
		echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		echo Detected System ......
		echo `hostnamectl | grep "Operating System"`
		echo `hostnamectl | grep "Kernel"`
		echo `hostnamectl | grep "Architecture"`
		echo Total No of packages `dpkg --list | wc --lines`
		echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		echo Showing memory usage
		df -h
		echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		echo Initiate Cleaning 🧹🧹🧹🧹🧹 

		sudo apt-get autoremove
		sudo apt-get autoclean
		
		lv_loop_ct2=0
		while true 
		do

			echo Do you want to clean trash [y/n]
			read choice

			if [ $choice == "y" ];
			then
				echo sizeof trash :`du -hs ~/.local/share/Trash`
				rm -r ~/.local/share/Trash/info/ && rm -r ~/.local/share/Trash/files/
				echo after cleaning trash :`du -hs ~/.local/share/Trash`
				break
			fi

			if [ $choice == "n" ];
			then
				break
			fi

			if [[ $choice != "y" && $choice != "n" ]];
			then
				lv_loop_ct2=`expr $lv_loop_ct2 + 1`
				echo either y or n is accepted 
			fi

			if [ $lv_loop_ct2 -gt 2 ];
			then
				echo "Maximum attempt reached exit 0"
				break
			fi

		done
		echo Cleanup finished 😃😃 More featurers will be added soon 😃😃
		break

	else
		lv_loop_ct=`expr $lv_loop_ct + 1`
	fi
done

if [ $lv_loop_ct -gt 9 ];
then
	echo -e "😥😥😥 \e[1:31m No active internet connection found , aborting\e[0m 😥😥😥 "
fi

