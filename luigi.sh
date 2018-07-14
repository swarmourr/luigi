#!/bin/bash
#title           :luigi.sh
#description     :This script will configure luigi server with python scripts.
#author		 :Swarmourr
#date            :20180714
#version         :1   
#usage		 :bash luigi.sh
#notes           :Install pip and luigi to use this script.
#bash_version    :4.4.12(1)-release 
#==============================================================================

today=$(date)
div=======================================

/usr/bin/clear

echo "
			 _        _______                    _______             _                _________ _______ _________
			( (    /|(  ___  )|\     /||\     /|(  ___  )|\     /|  ( \      |\     /|\__   __/(  ____ \\__   __/
			|  \  ( || (   ) || )   ( || )   ( || (   ) |( \   / )  | (      | )   ( |   ) (   | (    \/   ) (   
			|   \ | || |   | || |   | || | _ | || (___) | \ (_) /   | |      | |   | |   | |   | |         | |   
			| (\ \) || |   | |( (   ) )| |( )| ||  ___  |  \   /    | |      | |   | |   | |   | | ____    | |   
			| | \   || |   | | \ \_/ / | || || || (   ) |   ) (     | |      | |   | |   | |   | | \_  )   | |   
			| )  \  || (___) |  \   /  | () () || )   ( |   | |     | (____/\| (___) |___) (___| (___) |___) (___
			|/    )_)(_______)   \_/   (_______)|/     \|   \_/     (_______/(_______)\_______/(_______)\_______/ 

			=========================== $today ==============================
"


#terminal text colours code
cyan='\e[0;36m'
green='\e[0;32m'
lightgreen='\e[0;32m'
white='\e[0;37m'
red='\e[0;31m'
yellow='\e[0;33m'
blue='\e[0;34m'
purple='\e[0;35m'
orange='\e[38;5;166m'
path=`pwd`


if [ $(id -u) != "0" ]; then
echo -e $red [x]::[not root]: You need to be [root] to run this script.;
      echo ""
   	  sleep 1
exit 0
fi

which pip> /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] pip......................[ found ]" $white 
sleep 1
else
echo -e $red "[ X ] pip  -> not found" $white 
apt-get install python-pip
fi

which luigi > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] luigi....................[ found ]" $white 
sleep 1
else
echo -e $red "[ X ] luigi  -> not found" $white 
pip install luigi
fi

echo -e $blue"luigi server configuration" $white 
 	echo -e $yellow      "         Running luigi on port 8080 " $white 
		luigid --port 8080  > /dev/null 2>&1
        echo -e $green "[ ✔ ] port configuration ...................[ ok ]" $white 
	
echo -e $yellow      "         Configuring server path " $white 
		serverPath=$(readlink -f server.py)

	if [ -f $serverPath ]
then
        echo -e $green "[ ✔ ]  $serverPath ...................[ found ]" $white 
else 
	echo -e $red" [ X ] $serverPath  -> not found" $white 

fi	

        echo -e $yellow "         Luidgi server is running " $white 
	
	python $serverPath > /dev/null 2>&1

if [ $? -eq 0 ]; then 
        echo -e $green "[ ✔ ]   server startup ...................[ OK ]" $white 
else
	echo -e $red "[ X ]   server startup ...................[ fail]" $white 
fi


        echo -e $yellow "         Running the luigi script " $white 

	scriptLuigi=$(readlink -f scriptLuigi.py)
	hostName='127.0.0.1'
	
python  $scriptLuigi --scheduler-host $hostName Copy --dataBaseName admin > /dev/null 2>&1

if [ $? -eq 0 ]; then 
        echo -e $green "[ ✔ ]   $scriptLuigi  ...................[ OK ]" $white 
else
	echo -e $red "[ X ]   $scriptLuigi ...................[ fail]" $white 
fi




