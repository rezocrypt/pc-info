#!/bin/bash

# Function for printing author that this is powered by RESONANCE
print_resonance_powered()
{
	echo -e "\n\n\n\033[1;32mPowered by \033[1;31mR\033[1;34mE\033[1;33mS\033[1;31mO\033[1;34mN\033[1;33mA\033[1;31mN\033[1;34mC\033[1;33mE"	
}

# Getting sudo permissions for other operations
sudo echo -n "" 
# Copying bash script to /bin/
sudo cp resopcinfo.sh /bin/resopcinfo && sudo chmod 777 /bin/resopcinfo 
echo -e "\033[0;32m"
echo -e "Now you can see your pc information by typing    \033[34m resopcinfo \033[0m"
print_resonance_powered