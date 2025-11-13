#!/bin/bash

# Clearing screen if user selected clear screen option
clear_screen()
{
	if [[ $1 == "--clear-screen" ]] || [[ $2 = "--clear-screen" ]] ; then
		clear
	fi
}

# Defining variables
declare -i global column_count=$(tput cols)
second_argument=$2
third_argument=$3

# Defining functions

# Function for picking color
choose_color()
{
	# This if is for resetting color if you select r
	if [[ $1 == "r"  ]] ; then
		echo -ne "\033[1;0m"
	elif [[ $1 == "red" ]] ; then
		echo -ne "\033[1;31m"
	elif [[ $1 == "cyan" ]] ; then
		echo -ne "\033[1;36m"
	elif [[ $1 == "green" ]] ; then
		echo -ne "\033[1;32m"
	elif [[ $1 == "yellow" ]] ; then
		echo -ne "\033[1;33m"
	fi
	if [[ $second_argument == "--no-color" ]] ||
	[[ $third_argument == "--no-color" ]] ; then
		echo -ne "\033[1;0m"
	fi
}

# Function which will fill whole line with "-" (short of Fill Line)
fill_line()
{
	choose_color "cyan"
        for i in $(seq $column_count)
        do
                echo -n "-"
        done
	choose_color "r"
}

# Function for printing given text in the middle
print_paragraph()
{
	choose_color "green"
        n=$((`echo $1 | awk '{print length}'` / 2))
        declare -i count=$(( $column_count / 2  - $n ))
        for i in $(seq $count)
        do
                echo -n " "
        done
        echo -ne  $1 "\n"
	choose_color "r"
}

# Function for getting information about RAM
ram_info()
{
	sudo echo
        fill_line
        print_paragraph "RAM information"
        # Getting RAM information from "free -h" command
	choose_color "red"
	echo -ne "Type          : "
	choose_color "yellow"
	sudo dmidecode -t memory | grep "Type: D" | awk '{print $2}'
	choose_color "red"
	echo -ne "Frequency     : "
	choose_color "yellow"
	sudo dmidecode --type 17 | grep -m1 "Speed" | awk '{print $2 " MHz" }'
	choose_color "red"
	echo -ne "Total memory  : "
	choose_color "yellow"
	free -h | grep Mem |  awk '{print $2}'
	choose_color "red"
	echo -ne "Used memory   : "
	choose_color "yellow"
	free -h | grep Mem |  awk '{print $3}'
	choose_color "red"
	echo -ne "Free memory   : "
	choose_color "yellow"
	free -h | grep Mem |  awk '{print $4}'
	fill_line
}

# Function for operation system information (and also bash and vim version)
os_info()
{
	fill_line
	print_paragraph "OS information"
	choose_color "red"
	echo -ne "Kernel        : "
	choose_color "yellow"
	echo -e  `uname -r`
	choose_color "red"
	echo -ne "Name          : "
	choose_color "yellow"
	echo -e  `uname -mrs`    
	choose_color "red"
	echo -ne "Shell         : "
	choose_color "yellow"
	ps | grep -m1 "pts" | awk '{print $4}'
	choose_color "red"
	echo -ne "Vim version   : "
	choose_color "yellow"
	vi --version | head -n1 | awk '{print $5}'
	fill_line
}

# Function for getting info about CPU
cpu_info()
{
	fill_line
	print_paragraph "CPU information"
	choose_color "red"
	echo -ne "Model         : "
	choose_color "yellow"
	lscpu | grep "Model name" |
	awk '{for (i=3; i<NF; i++) printf $i " "; print $NF}'
	choose_color "red"
	echo -ne "Max Frequency : "
	choose_color "yellow"
	lscpu | grep "max" | awk -v ORS=" " '{print $4;print "MHz"}'
	choose_color "red"
	echo -ne "\nMin Frequency : "
	choose_color "yellow"
	lscpu | grep "min" | awk -v ORS=" " '{print $4;print "MHz"}'
	choose_color "red"
	echo -ne "\nCores count   : "
	choose_color "yellow"
	lscpu | grep -m1 "CPU(s)" | awk '{print $2}'
	fill_line
}

# Function for getting information about disks inside pc
disk_info()
{
	fill_line
	print_paragraph "DISK information"
	diskinfo=`sudo fdisk -l  | grep -i '^Disk /dev/'`
	declare -i n=1
	declare -i r=0
	for disk in $diskinfo
	do
		r=`expr $n%8`
		if [[ $r == 2 ]] ; then
			choose_color "red"
			echo -n "Type          : "
			choose_color "yellow"
			echo $disk |  awk -F[/:] '{print $3}'
		elif [[ $r == 3 ]] ; then
			choose_color "red"
			echo -n "Size          : "
			choose_color "yellow"
			echo -n $disk 
		elif [[ $r == 4 ]] ; then
			echo -e ${disk::-1} "\n"
		fi
		n=n+1
	done
	fill_line
}

# Function for getting information about GPU
gpu_info()
{
	fill_line
	print_paragraph "GPU information"
	choose_color "red"
	echo -ne "Model         : "
	choose_color "yellow"
	lspci -v | grep -m1 "VGA compatible controller" | 
	awk '{for (i=5; i<NF; i++) printf $i " "; print $NF}'
	choose_color "red"
	echo -ne "Driver        : "
	choose_color "yellow"
	lspci -k | grep -m1 -A1 "VGA" |
	awk 'NR==2{ print; }' |
	awk '{print $5}' 
	choose_color "red"
	echo -ne "GPU RAM       : "
	choose_color "yellow"
	lspci -v | grep -A3  VGA | grep size | awk '{print $6}' |
	cut -d "=" -f2 |  sed 's/.$//' 
	fill_line
}

# Function for argument_help
print_argument_help()
{
	choose_color "red"
	echo "Arguments:"
	choose_color "green"
	echo -e "    -r          : RAM information"
	echo -e "    -o          : OS information"
	echo -e "    -c          : CPU information"
	echo -e "    -d          : DISK information"
	echo -e "    -g          : GPU information"
	echo -e "    -a          : All information"
	echo -e "    -h          : Help information\n"
	choose_color "red"
}

# Function for options help
print_option_help()
{
	echo "Options:"
	choose_color "green"
	echo -e "    --no-color             : Prints output without colors"
	echo -ne "    --clear-screen         : Clears screen "
	echo -e "before printing output\n" 
	choose_color "red"
}

# Function for error help
print_error_help()
{
	echo "Errors:"
	choose_color "green"
	echo -e "    WRONG ARGUMENT             : Argument not found"
	echo -ne "    ARGUMENT REPETITION ERROR      : You wrote "
	echo -ne "the same argument"
	echo -e " two or more times\n"
	choose_color "red"
}

# Function for printing author that this is powered by RESONANCE
print_resonance_powered()
{
	echo -e "\n\n\n\033[1;32mPowered by \033[1;31mR\033[1;34mE\033[1;33mS\033[1;31mO\033[1;34mN\033[1;33mA\033[1;31mN\033[1;34mC\033[1;33mE"	
}

# Function for how_to_use help
print_how_to_use_help()
{
	echo -e "How to use:\t"
	choose_color "green"
	echo -n "First argument must be information which you want" \
	" to see for example "
	choose_color "red"
	echo -n "resopcinfo -r"
	choose_color "green"
	echo -n " which will print about ram, but"
	echo -n " you also can do something like this "
	choose_color "red"
	echo -n "resopcinfo -rco"
	choose_color "green"
	echo -en " which will print information about \033[1;31mr\033[1;32mam," 
	echo -en " \033[1;31mc\033[1;32mpu and  \033[1;31mo\033[1;32ms"
	choose_color "green"
	echo  " But remember you cannot use the same argument" \
	" multiple times otherwise you will get an error."
	echo -ne "If you want to print information "
	echo -e "without colors use  \033[1;31mresopcinfo" \
	" --no-color  \033[1;32mas second or third argument (not first)."
	echo -e "And if you want to clear screen before printing information" \
	" just write  \033[1;31mresopcinfo --clear-screen."
	print_resonance_powered
}
# Function for help option
help_info()
{
	fill_line
	print_paragraph "ResoPcInfo HELP"
	print_argument_help
	print_option_help
	print_error_help
	print_how_to_use_help	
	fill_line
}

# Function for printing error when it gets wrong argument
wrong_argument_error()
{
	echo -ne "\033[1;31mERROR: WRONG_ARGUMENT_ERROR"
	echo -e "\033[1;33m \n\nYou chose wrong argument."
	echo -ne "Try again with double-checking arguments"
	echo -e " written by you.\n"
	echo -e "If you need help run script with argument -h"
}

# Function for printing error when there is no argument
no_argument_error()
{
	echo -ne "\033[1;31mERROR: WRONG_ARGUMENT_ERROR"
	echo -e "\033[1;33m\n\nYou did not use any argument."
	echo -e "Try again with using arguments.\n"
	echo -e "If you need help run script with argument -h"
}

# Function for argument repeat error
argument_repeat_error()
{
	echo -e "\033[1;31mERROR: ARGUMENT_REPETITION_ERROR\033[1;33m\n"
	echo -ne "You repeated the same argument more"
	echo -ne " than one time.\nTry again without using"
	echo -e " same argument one or more time.\n"
	echo -e "If you need help run script with argument -h"
}

# Calling clear screen function
clear_screen $2 $3

# This function prints information reading arguments
run_arguments()
{
	for cm in $(echo "${1:1}" | grep -o .) ; do
		if [[ $cm == r ]] ; then
			ram_info
		elif [[ $cm == o ]] ; then
			os_info
		elif [[ $cm == c ]] ; then
			cpu_info
		elif [[ $cm == d ]] ; then
			disk_info
		elif [[ $cm == g ]] ; then
			gpu_info
		elif [[ $cm == h ]] ; then
			help_info
		elif [[ $cm == a ]] ; then
			ram_info
			os_info
			cpu_info
			disk_info
			gpu_info
		fi	
	done
}

# Main argument checking and command running part
main()
{
	if [[ $1 == -* ]] ; then
		true_input="true"
		# Looping in every character of string and checking
		# argument which user wrote
		if [[ $true_input == true ]] ; then
			for cm in $(echo "${1:1}" | grep -o .)
			do
				if [[ $cm == r ]] || [[ $cm == o ]] ||
				[[ $cm == c ]] || [[ $cm == d ]] ||
				[[ $cm == g ]] || [[ $cm == h ]] ||
				[[ $cm == a ]] ; then
					echo -n
				else
					true_input="wrong_argument"
				fi
			done
		fi
		if [[ $true_input == true ]] ; then
			if echo "$1" | grep -q '\(.\).*\1' ; then
				true_input="argument_repeat_error"
			fi	
		fi
		if [[ $true_input == true ]] ; then
			run_arguments $1	
		elif [[ $true_input == wrong_argument  ]] ; then
			wrong_argument_error
		elif [[ $true_input == argument_repeat_error ]] ; then
			argument_repeat_error
		fi	
	else
		no_argument_error
	fi
}

# Calling main function which will do everything
main $1
