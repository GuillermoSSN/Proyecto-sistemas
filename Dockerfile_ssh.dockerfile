# Use una imagen base de Ubuntu

FROM ubuntu:latest



# Actualizar e instalar el servidor SSH

RUN apt-get update && apt-get install -y openssh-server



# Copiar el archivo de configuración del servidor SSH

COPY sshd_config /etc/ssh/sshd_config



# Copiar los scripts ssh.sh y menu.sh

COPY ssh.sh /usr/local/bin/ssh.sh

COPY menu.sh /usr/local/bin/menu.sh



# Dar permisos de ejecución a los scripts

RUN chmod +x /usr/local/bin/ssh.sh

RUN chmod +x /usr/local/bin/menu.sh



# Crear un directorio para las claves SSH

RUN mkdir /var/run/sshd



# Establecer una contraseña para el usuario root (¡Cambia esto por una contraseña segura!)

RUN echo 'root:guille' | chpasswd



# Exponer el puerto 22 para SSH

EXPOSE 22



# Ejecutar el servidor SSH cuando se inicie el contenedor

CMD ["/usr/sbin/sshd", "-D"]