#!/bin/bash
while true; do
echo "OPCIONES"
echo "---------------------------"
echo "0. Instalar ssh"
echo "1. Cambiar puerto"
echo "2. Crear una lista negra"
echo "3. Crear una lista blanca"
echo "4. Poner el marcha el servicio"
echo "5. Parar el servicio"
echo "6. Ver el estado del servicio"
echo "7. Eliminar el servicio ssh"
echo "8. salir"
echo "----------------------------"
	read -p "Elige una opción " opcion
	prueba=$(echo $opcion | grep -E "^[0-8]{1}\b")
if [ -z "$prueba" ]; then
	echo "Lo escribe un numero que este dentro del parametro"
else
	if [ $opcion -eq "0" ]; then
		prueba1=$(sudo systemctl status ssh | grep -E "running")
		prueba2=$(sudo systemctl status ssh | grep -E "dead")
		if [ -z "$prueba1" -a -z "$prueba2" ]; then
			echo "El servicio no esta instalado"
			sudo apt install openssh-server -y
		else
			echo "El servicio si esta instalado"
		fi
	fi
	if [ $opcion -eq "1" ]; then
		bash ssh.sh -p
	fi
	if [ $opcion -eq "2" ]; then
		sudo bash ssh.sh -d
	fi
	if [ $opcion -eq "3" ]; then
		sudo bash ssh.sh -a
	fi
	if [ $opcion -eq "4" ]; then
		echo "El servicio se esta poniendo en marcha"
		sudo systemctl start ssh
	fi
	if [ $opcion -eq "5" ]; then
		echo "El servicio se esta parando"
		sudo systemctl stop ssh
	fi
	if [ $opcion -eq "6" ]; then
		echo "Vamos a ver el estado del servicio" 
		prueba3=$(sudo systemctl status ssh | grep -E "running")
		prueba4=$(sudo systemctl status ssh | grep -E "dead")
		if [ -n "$prueba3" ]; then
			echo "El servicio esta activo"
		fi
		if [ -n "$prueba4" ]; then
			echo "El servicio esta parado"
		fi
	fi
	if [ $opcion -eq "7" ]; then
		echo "El servicio se desistalo"
		sudo apt-get purge openssh-server -y
	fi
	if [ $opcion -eq "8" ]; then
		echo "Adios"
		break
	fi
fi
done

