# lamp_dos_niveles
## Automatización de infraestructura LAMP en dos niveles

Crearemos una infraestructura LAMP en dos niveles para desplegar la aplicación web [iaw-practica-lamp](https://github.com/josejuansanchez/iaw-practica-lamp.git)

La infraestructura estará compuesta por dos máquinas Debian, una tomará el rol de servidor de base de datos y la otra el servidor apache.

#### Host AbelGijonApache, servidor apache2:
![apache2](https://github.com/abelgc84/lamp_dos_niveles/assets/146434908/2f98d0f1-4d79-4916-bd5a-855b0959d44f)

#### Host AbelGijonMysql, Servidor Mysql:
![mysql](https://github.com/abelgc84/lamp_dos_niveles/assets/146434908/3a2c148d-d160-4664-aa98-8a8b0ccaccbc)

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
