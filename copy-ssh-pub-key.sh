#!/bin/bash

# El objetivo de este script es el de copiar tu clave pública a una lista dada de servidores. Puede ser la lista de ips de tu cliente, de testing, o una lista random.

# En un futuro se creará otro script, o se mejorará este para ponerle alias a cada una de estas ip.
# Que lindo loguearse al al local 26 de farmashop poniendo simplemente ssh fsh-local27
# O entrar a la caja 4 del local 13 con ssh fsh-local13-caja1

# Flujo para copiar tu clave pública.
#
# 1 - ssh-keygen -t rsa
# 2 - especificar lugar donde se va a guardar 
# 3 - especificar password (presionar enter sin setear password sino no tiene sentido esto)
# 4 - ssh-add <ruta del rsa_id.pub> (default /home/<user>/.ssh/rsa_id.pub NOTA: si no se cambia la ruta la agrega directamente de esta ruta)
# 5 - ssh-copy-id <usuario>@<ip> ingresar password.  <== Esto es lo que hay que repetir.

CONF_FILE='.conf'
LOG_FILE=$(basename $0 .sh).log
# Funciones varias
function Log {
    DATE=$(date +%Y-%m-%d' '%H:%M:%S);
    echo "$DATE - $1"
    echo "$DATE - $1" >> $LOG_FILE
}
function LogInfo(){
    Log "INFO - $1"
}
function LogError(){
    Log "ERROR - $1"
}


# Función que chequea el codigo de salida de un comando
function CheckCommand() {
	if [ ! $1 -eq 0 ]; then
		LogError "SALIDA:ERROR - $2"
		exit 1
	fi
}

# Verifico si existe una rsa_id.pub, si no existe la creo.
if [ ! -f ~/.ssh/id_rsa.pub ]; then
	ssh-keygen
	CheckCommand $? "Ocurrió un error al generar la clave"
	# Agrego la clave al ssh-agent
	ssh-add
	CheckCommand $? "Ocurrió un error al agregar la clave al ssh-agent"
fi

# Función que recibe una ip y ejecuta ssh-copy-id en dicha ip
function CopyId(){
	sshpass -f $CONF_FILE ssh-copy-id $1
	CheckCommand $? "Ocurrió un error al intentar copiar la clave"
}

# Recorro el servidores.txt
Log "Comienzo proceso de copiado de llaves"
for Item in $(cat servidores.txt|cut -d"," -f3);do
	Log "==============$Item================"
	CopyId root@$Item |& tee -a $LOG_FILE
done
Log "Finalizo proceso de copiado de llaves"
Log "====================================="
