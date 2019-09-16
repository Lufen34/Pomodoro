#!/bin/bash

cat << "EOF"
  _____                          _                 
 |  __ \                        | |                
 | |__) |__  _ __ ___   ___   __| | ___  _ __ ___  
 |  ___/ _ \| '_ ` _ \ / _ \ / _` |/ _ \| '__/ _ \ 
 | |  | (_) | | | | | | (_) | (_| | (_) | | | (_) |
 |_|   \___/|_| |_| |_|\___/ \__,_|\___/|_|  \___/   

EOF

work_time=1800
rest_time=300

prog() {
    local w=80 p=$1;  shift
    # create a string of spaces, then change them to dots
    printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /.};
    # print those dots on a fixed-width space plus the percentage etc. 
    printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*"; 
}

numberOfLoop=1
paplay /usr/share/sounds/deepin/stereo/desktop-login.wav 
echo "============================================================================" && echo "$(tput setaf 2)Your pomodoro session just started. Good luck !!$(tput sgr0)" && echo "============================================================================";
# test loop
for x in {1..100} ; do
    prog "$x" still working...
    sleep 18   # do some work here
done ; echo
echo "============================================================================" && echo "$(tput setaf 2)Your pomodoro session just ended. Have a well deserved 5 minutes break$(tput sgr0)" && echo "============================================================================";
paplay /usr/share/sounds/deepin/stereo/system-shutdown.wav  
sleep $rest_time && echo "===============" && echo "$(tput setaf 1)Back to work$(tput sgr0)" && echo "===============";
# test loop
for x in {1..100} ; do
    prog "$x" still working...
    sleep 3   # do some work here
done ; echo


echo "Do you want to continue ? press y or n"

read answervar

while [[ $answervar = 'y' ]]; do
	paplay /usr/share/sounds/deepin/stereo/desktop-login.wav
	echo "============================================================================" && echo "$(tput setaf 2)Your pomodoro session just started. Good luck !!$(tput sgr0)" && echo "============================================================================";
	# test loop
	for x in {1..100} ; do
	    prog "$x" still working...
	    sleep 18   # do some work here
	done ; echo
	echo "============================================================================" && echo "$(tput setaf 2)Your pomodoro session just ended. Have a well deserved 5 minutes break$(tput sgr0)" && echo "============================================================================";
	paplay /usr/share/sounds/deepin/stereo/system-shutdown.wav 
	sleep $rest_time && echo "===============" && echo "$(tput setaf 1)Back to work$(tput sgr0)" && echo "===============";
	# test loop
	for x in {1..100} ; do
	    prog "$x" still working...
	    sleep 3   # do some work here
	done ; echo
	echo "Do you want to continue ? press y or n"
	read answervar
	((numberOfLoop++))
	if [[ $numberOfLoop > 3 && $answervar = 'n' ]]; then
		echo "$(tput clear)"
		echo "$(tput setaf 5)A well deserved gaming break awaits you.$(tput sgr0)"
		paplay /usr/share/sounds/deepin/stereo/system-shutdown.wav
	fi
done