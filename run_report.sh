#!/bin/bash

#pars user option
#using a loop to pick up flags like -a or -w (flaps)
#loop and when when it finds a certain flag then it stores that

usage(){
	echo "Invalid options"
	echo "Usage ./$0 -s <> -c <> -w<>"
	exit 1
}

#check for help arg

if [[ $1 == "--help" ]]
then
	usage
fi



#looping for flags/ options -s -w -c
while getopts ":s:w:c:" opt #once it finds it, it is stored in opt
do 
	case $opt in 
		s) size=$OPTARG 
        		;;
		w) width=$OPTARG
			;;
		c) color=$OPTARG
			;;
		\?)#anything else is invalid option
			usage
			;;
	esac


done

if [[ -z $size ]] #check if size is empty
then
	echo "s is required"
	usage
fi

echo "[$size] [$width] [$color]"

exit 0
