#!/bin/bash

if [ -z "$1" ]
then
        echo -e  "\e[33m[*]Uso:\e \e[32m ./nmapScan +\e[0m" "\e[31m{IP}\e[0m"
        exit 1
fi
printf "\n[*] Puertos Abiertos:\n\n" > OpenPorts
echo -e "\e[31m Escaneando Puertos Abiertos...\e[0m"
sudo nmap -sS -p- --open --min-rate 5000 $1 -n -Pn | tail -n +5 | head -n -3 >> OpenPorts
cat OpenPorts
open_ports="$(cat OpenPorts | awk -F '/' '/open/{print $1}' | paste -s -d,)"
printf "\n[*] Servicios corriendo:\n\n" > Targeted
echo -e "\e[31m Escaneando Servicios...\e[0m"
nmap -sC -sV -Pn -n -p $open_ports $1 >> Targeted
cat Targeted

