#!/bin/bash

# Vista Version Manager
# Written by Drew Shipps

# Examples:
# vvm use 3.R3.21755
# vvm -v
# vvm -h


# Colors
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
cyan=`tput setaf 6`
reset=`tput sgr0`


# Load Previous Vista Version Number
lastversion=`cat "/users/drewshipps/Documents/Vista/VERSIONS/vvm_lastversion.config"`


# Functions
version() {
   echo "vvm 1.1"
   exit 0
}

help() {
   echo "Vista Version Manager (version 1.1)"
   echo "Written by Drew Shipps"
   echo "A bash script for managing multiple versions of Vista by Chroma Q."
   echo ""
   echo "Examples:"
   echo "vvm use 3.R3.21755 | Activate version 3.R3.21755 of Vista"
   echo "vvm -v | Print the current version of Vista Version Manager"
   echo "vvm -h | Dispaly this help menu"
   exit 0
}


# Flags
while getopts 'vh' flag; do
  case "${flag}" in
    v) version ;;
    h) help ;;
  esac
done


# if no arguments provided
if [ $# -eq 0 ]; then
   echo "${red}No arguments provided. Try vvm -h${reset}"
   exit 1
fi



# "use" Command
if [ ${1} == "use" ]; then
   VERSION=${2}
   if [[ "${VERSION:0:1}" -eq 0 ]]; then
      echo "${red}Warning: No version provided.${reset}"
   else 

      if [ $lastversion == $VERSION ]; then
         echo "${green}Version '$VERSION' is the current version.${reset}"
         exit 0
      else
         if [ -d "/users/drewshipps/Documents/Vista/VERSIONS/Vista $VERSION" ]; then
            echo "${green}Activating version '$VERSION' of Vista by Chroma Q${reset}"
            echo "${blue}Version '$VERSION' found${reset}"

            if [ "/users/drewshipps/Documents/Vista/Vista.app" ]; then
               echo "${blue}Moving previous copy of Vista to ~/Documents/Vista/VERSIONS/Vista $lastversion${reset}"
               mv "/users/drewshipps/Documents/Vista/Vista.app" "/users/drewshipps/Documents/Vista/VERSIONS/Vista $lastversion"
            fi
            if [ "/users/drewshipps/Documents/Vista/Vista 3" ]; then
               echo "${blue}Moving previous Vista data folder to ~/Documents/Vista/VERSIONS/Vista $lastversion${reset}"
               mv "/users/drewshipps/Documents/Vista/Vista 3" "/users/drewshipps/Documents/Vista/VERSIONS/Vista $lastversion"
            fi

            echo "${blue}Moving version $VERSION to ~/Documents/Vista/${reset}"
            mv "/Users/drewshipps/Documents/Vista/VERSIONS/Vista $VERSION/"* "/Users/drewshipps/Documents/Vista/"
            
            echo $VERSION > "/users/drewshipps/Documents/Vista/VERSIONS/vvm_lastversion.config"

            echo "${green}Activated version '$VERSION' of Vista by Chroma Q${reset}"
            exit 0
         else
            echo "${red}Warning: Vista version $VERSION not found.${reset}"
            exit 1
         fi
      fi
   fi
else 
   echo "${red}Warning: Command ${1} not supported${reset}"
fi


