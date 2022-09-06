#!/bin/bash
#Autor: Carlos Rubio
#escanea la red local en búsqueda de host activos

clear

 if [ $(id -u) -ne 0 ]; then

	echo '\e[31m [ERROR] \e[0m Debes ejecutar el script como root'
	exit 1
 fi

# banner
echo

	toilet -f mono12 -F border:metal HostScan

echo

# Opciones para el usuario
 echo
 echo "\e[32m 1. \e[0m Comprobar ip y máscara "
 echo
 echo "\e[32m 2. \e[0m Empezar el escaneo"
 echo
 echo "\e[31m 3. \e[0m Salir."
 echo
 echo


read -p "elige una opción: " opt

case $opt in


	1) # Comprobar ip y máscara

		ifconfig | grep inet | head -n1
		;;

	2) #Empezar el escaneo

	 echo
	 echo "\e[35m puedes cancelarlo con (Cntrl+C) o pasarlo a segundo plano (Cntrl+Z), podrás volver a verlo en primer plano use (fg) \e[0m"
	 echo

	 read -p"Ingrese su porción de red [Ej: 192.168.0]: " net
	 echo
	 for ip in $(seq 1 254); do

	 #probar si hay algún host activo

		ping -c 1 $net.$ip > /dev/null

		#comprueba la salida del ping anterior.

		if [ $? -eq 0 ]; then

			echo $net.$ip is '\e[32m UP \e[0m'

		else

			echo $net.$ip is '\e[31m Down \e[0m'

		fi

	done
	break
	;;

	3) #Salir

	echo 'Saliendo del script..'
	sleep 1
	exit 1
esac



