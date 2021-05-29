#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
cyan=`tput setaf 6`
reset=`tput sgr0`

VERSION=${1}
lastversion=`cat "/users/drewshipps/Documents/Vista/VERSIONS/vvm_lastversion.config"`
anyOtherVersionsFound=0

if [ ${1} == "-v" ]; then
   echo "${blue}Vista Version Manager (version 1.0)${reset}"
   exit 0
fi

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