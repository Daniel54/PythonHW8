#!/bin/bash

#pars user option
#using a loop to pick up flags like -a or -w (flaps)
#loop and when when it finds a certain flag then it stores that

usage(){
	echo "Invalid options"
	echo "Usage ./$0 -f <BegDate> -t <EndDate> -e<Email> -u <User> -p<Pass>"
	exit 1
}

#check for help arg

if [[ $1 == "--help" ]]
then
	usage
fi

#Make a funciton that that uses BegDate and EndDate 
#passes it to python script


#looping for flags/ options -s -w -c
while getopts ":f:t:e:u:p:" opt #once it finds it, it is stored in opt
do 
	case $opt in 
		f) BegDate=$OPTARG 
        	;;
		t) EndDate=$OPTARG
			;;
		e) email=$OPTARG
			;;
		u) user=$OPTARG
			;;
		p) passwd=$OPTARG
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
