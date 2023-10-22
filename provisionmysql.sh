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