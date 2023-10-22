# lamp_dos_niveles
## Automatización de infraestructura LAMP en dos niveles

Crearemos una infraestructura LAMP en dos niveles para desplegar la aplicación web [iaw-practica-lamp](https://github.com/josejuansanchez/iaw-practica-lamp.git)

La infraestructura estará compuesta por dos máquinas Debian, una tomará el rol de servidor de base de datos y la otra el servidor apache.

#### Host AbelGijonApache, servidor apache2:
![](https://lh3.googleusercontent.com/pw/ADCreHeiQmPjr2gWe7hF7cthPVPMJSwWp7MkZMq-569WZ3CVn1NePCz6cZ9f6ccIuwnJNWC20E84C7CkvLHGtwpdlT-7zpk3JZXd3TH9sJEAjs0aB5NAHpNfR6UTbdsuHAEvIaVOlG8rckn8iCaxCibtY5BtlJxeBGhKWp4JKsdCfrpSAWT1aXg8gGGFN3v0oHzs0-1yFxZs_aCoRJfobnNw3jEvuQFM913sLfV1oWUHbH2R9QMeWN9TPoANfvHJKaSdIM8VAhvjU0Q4dyk-e0BOIZd7OYXIPxFijldKngbRS8txqyFPmYT8eHYUq_jQubezdLGTCUlvR5fQeT5aS0Wy4COlRrpux9UF2Wqk6qWpUidUfnDJLdv04d1CFW9uZxhnxDorUvB6UXIpAvfcO2xTlugof_j5imqWfLGLDx-FI0TJBD5QERpAIn5F37EGLbJXa71rfT0CoeC089oteDLMZTw9GnJ_zTba0yUapMpJ7HoVPiEjlGx3MLWMGJnKE6cCSJjWX89OPQDTHqh2rERmRqpkIOVFmdv5ZRpdPdrLdc8jNZbRp1hVUL0cK52VVzk65-3BPiiEufFXOvOhq3nomJSj0snNdCI6uZ6oySICJ3f2YrhYo-5s1ZLuRnfu6kEm5gHYB8ynMX6HJMDErveOaQajPH2sS5bQSzNpczKYQVkVHU6YSb7ownvjZ78TSeEGRC2XjElPtgE7-NCS9EZzosJoiVUhE7uHaYx6KuNulx2EfGFXRqqys-MnvkL3SxQlQgKBrMMlwuh3bsMO6vR0y7o1HGaQG2rK59K10J_5y1SkFqnwZBLR2TeCiUzLhsRKa-MHxvMd7aktIBF9Uc8BWwspRy8kypxg4wqfBmjVepD3yQGmoQgEg6DhOQB1NjHhzZ5o3UY3sSJ9ZGPAxGw_jg=w1482-h621-s-no-gm?authuser=0)

#### Host AbelGijonMysql, Servidor Mysql:
![](https://lh3.googleusercontent.com/pw/ADCreHc778wWH-WUMl0xkNpRDmqUi9n3uO29O5DZuzVqP7zS9pO-C5oIMAtBcDqa7SlbHlf30hXPLgl8JUt6lWRVE0J5hKKJA3BoFvJMsVHDPaJOkeserruHAUsPKcZKIHHiqQgsIfBa2EPr9ImN9nN4mSKfWtDFCpvW8OaUFSD99sjhTwhP3ZDJgeR3DVy_qrIdf8mulZBfGnsh3x4AnhBHzedhz85JzZQs9e2CnE_1vbLLGpMCXR66t0bsHtDR7dSjEv3w3HsXAOLGiSKX32KUDYuQIgt9BvoVhsVqDU6pHzjYMCcVDVBLVrcRBAAujoqN52_RuX6e15J76iXtNnGJvTTKx1em6uCXWKeCH9zOKqMmz2T7E63Ir-r4aL1PeOqYjWqn6OP7uEXrHXJ07JFkVikkLsIqNlO5ylgWwcKIf2HUDBtyCzaiUcK5XmdIGu0HlaPj1DWpgYXxUrwgrFMUC3mbWiNwkBO6Kh7S30x0N0hhw2uZT8kiJj5JWDZtm4DiP8D4Lkd2_ttID5ns_yjI2iFvjxhwjswd9PcMii0GfirMhXgXCMUMDUz26AQZQOY5mnezEkPr-7SmBT1iiigq28b1TQAv4KNlGj6i-AGVmwjtAchDvxVY0NSfO6YrXcGKC0qj3_beScDFYMJrOWB7H2Zi7XJktWFvawJpRfpZpsqqoqIWq6X0Azbl3wCmpTu2hAZZWUwh0f3vzYg17B74iCTu9gBZHTCcqmzsqNL34P0UE2XNZ0hswgoTnkLnmt56O14cLfqKoivKWpcLcny_OSwnmTqru-b15ts7XWLqMPfwhR_wrRAIcrO3wVKfDidfuRo5SMuYVMHeTv8J3n5YXg0dI3lXz0Vx1HtXyURA9Pr80MhRXzSVJRv8ku6V6ZUYxXSI31xYVtw3x1EcYgNlig=w1481-h550-s-no-gm?authuser=0)

Todas las instalaciones y configuraciones necesarias para cada máquina se encuentran en el script de provisionamiento, por lo que solo habrá que ejecutar vagrant up y la aplicación web se desplegará lista para su uso, como se observa en el [video](https://clipchamp.com/watch/8rpD0Qeb6Wa) 

#### Script provisionapache.sh
```
# Actualización del sistema.

echo "Actualizando repositorio"
sudo apt update
# echo "Actualizando sistema"
# sudo apt upgrade -y

# Instalación de apache

echo "Instalando apache2 en el sistema..."
sudo apt install -y apache2
echo "Apache2 ha sido instalado."

# Instalación de módulos PHP

echo "Instalando módulos PHP en el sistema..."
sudo apt install -y php libapache2-mod-php php-mysql
echo "Los módulos PHP han sido instalados"

# Edición de 000-default.conf
# Indico la nueva ruta DocumentRoot donde pondré la aplicación

echo "Modificando la ruta DocumentRoot"
sudo sed -i '/DocumentRoot/d; /ServerAdmin webmaster/a\        DocumentRoot /var/www/html/lamp2niveles/src' /etc/apache2/sites-enabled/000-default.conf
echo "La nueva ruta DocumentRoot es: /var/www/html/lamp2niveles/src"

# Instalación de git

echo "Instalando Git en el sistema..."
sudo apt install -y git
echo "Git ha sido instalado."

# Clonación del repositorio
# Compruebo si el repositorio existe y lo clono si no es así

archivo="/var/www/html/lamp2niveles/README.md"
if [ -f $archivo ]; then
    echo "El repositorio está disponible en $archivo"
else
    echo "Clonando el repositorio a /var/www/html/lamp2niveles"
    sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /var/www/html/lamp2niveles
    echo "Repositorio disponible"

    # Edición de config.php
    # Configuro el archivo con los parámetros de la base de datos

    echo "Aplicando configuración para conectar con la base de datos"
    sudo sed -i 's/localhost/192.168.100.200/' /var/www/html/lamp2niveles/src/config.php
    sudo sed -i 's/database_name_here/lamp_db/' /var/www/html/lamp2niveles/src/config.php
    sudo sed -i 's/username_here/abel/' /var/www/html/lamp2niveles/src/config.php
    sudo sed -i 's/password_here/1234/' /var/www/html/lamp2niveles/src/config.php
fi

# Instalación del cliente mariadb

echo "Instalando el cliente de mariadb en el sistema..."
sudo apt install -y mariadb-client
echo "Cliente de MariaDB se ha instalado."

# Reinicio el servicio de apache

sudo systemctl restart apache2
```

#### Script provisionmysql.sh
```
# Actualización del sistema.

echo "Actualizando repositorio"
sudo apt update
# echo "Actualizando sistema"
# sudo apt upgrade -y

# Instalación de git

echo "Instalando git en el sistema..."
sudo apt install -y git
echo "Git ha sido instalado."

# Instalación del server mariadb

echo "Instalando mariadb-server en el sistema..."
sudo apt install -y mariadb-server
echo "El servidor de MariaDB se ha instalado."

# Configuración de 50-server.cnf
# Modifico el user y el bind-address

sudo sed -i '/#user/d; /pid-file/i\user                    = abel' /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i '/bind-address/d; /# localhost/a\bind-address            = 192.168.100.200' /etc/mysql/mariadb.conf.d/50-server.cnf

# Configurar la base de datos
# Creo la carpeta donde almacenaré el repositorio y verifico si existe.

sudo mkdir /bd
archivo="/bd/README.md"

if [ -f "$archivo" ]; then
    echo "La base de datos ya está disponible."
else
    # Descargo el repositorio y ejecuto el script sql para cargar la base de datos
    echo "Descargando la base de datos."
    sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /bd
    sudo mysql -u root < /bd/db/database.sql
    echo "La base de datos ya está disponible."

    # Creo el usuario que tendrá acceso a la base de datos
    echo "Creando el usuario de la base de datos"
    sudo mysql -u root -e "CREATE USER abel@192.168.100.100 IDENTIFIED BY '1234';"
    sudo mysql -u root -e "GRANT ALL PRIVILEGES ON lamp_db.* TO abel@192.168.100.100;"
    sudo mysql -u root -e "FLUSH PRIVILEGES;"
    echo "Usuario creado"
fi

# Desactivar el acceso a Internet

echo "Desactivando el acceso a Internet"
sudo ip route del default

# Reinicio el servicio mysql

sudo systemctl restart mysql

# Configuración terminada

echo "Configuración terminada. La aplicación web está lista para su uso."
echo "Para acceder a ella visite la dirección 192.168.100.100 desde su navegador."
```
