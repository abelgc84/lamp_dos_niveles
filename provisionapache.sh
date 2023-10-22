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