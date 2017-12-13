# copy-ssh-pub-key

Este script sirve para poder copiar tu clave pública del ssh a una lista de servidores determinada.

## Modo de uso

Para poder utilizar el script hay ciertas consideraciones.

* La lista de computadoras a las cuales vamos a copiar nuestra clave pública tienen la misma contraseña.
* Debemos ingresar dicha contraseña en un archivo llamado .conf en el mismo directorio del script (o cambiar la variable CONF_FILE dentro del mismo)
* Por lo pronto la lista de servidores necesita ser un archivo llamado servidores.txt con una lista de un servidor por linea, y 3 campos por lineas separadas por coma. _NOTA: en un futuro esto va a ser más personalizado_

```
algo, algo, 192.168.1.1
algo, algo, 10.1.2.1
,,192.168.1.2
```

## Dependencias

Para poder automatizar el proceso el script hace uso de sshpass para no tener que ingresar la clave ssh en cada uno de los servidores que se agreguen al servidores.txt
