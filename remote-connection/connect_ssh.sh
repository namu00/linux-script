#!/bin/bash
SERVER_IP=0  #Your SERVER IP
SSH_PORT=22  #Your SSH PORT

#ACCOUND INFO
USER_ID="student03" #Your ID

#If you use RSA key, set key path here
RSA_KEY_PATH=""

#Check SERVER_IP validation
if [[ ${SERVER_IP} = 0 ]]; then
	echo "ERROR 1:"
	echo "SERVER_IP is not designated."
	exit 1;
fi

#Check USER_ID validation
if [[ ${USER_ID} == "" ]]; then
	echo "ERROR 2:"
	echo "USER_ID is not designated."
	exit 1;
fi

clear

#Notifiying Commnet
echo "--CONNECTION INFO--"
echo "[USER_ID]    : " ${USER_ID}
echo "[SERVER_IP]  : " ${SERVER_IP}
echo "[SSH_PORT]   : " ${SSH_PORT}

echo
echo

#SSH shell command
if [[ ${RSA_KEY_PATH} == "" ]]; then
	ssh ${USER_ID}@${SERVER_IP} -p ${SSH_PORT} 
else
	ssh ${USER_ID}@${SERVER_IP} -i ${RSA_KEY_PATH} -p ${SSH_PORT} 
fi
