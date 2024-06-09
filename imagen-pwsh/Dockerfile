# una imagen basada en Ubuntu con Powershell Core instalado, y con las dependencias indicadas por PSDepend incluidas
FROM ubuntu:jammy

RUN apt update && \
    apt install -y git wget

# crear el usuario Jenkins con contraseña jenkins
RUN useradd -m -d /var/jenkins_home -s /bin/bash jenkins
RUN echo 'jenkins:jenkins' | chpasswd

# instalar Powershell Core con un script
WORKDIR /root
COPY ./recursos-imagen/script-instalacion-pwsh.sh .
RUN chmod u+x script-instalacion-pwsh.sh && sh -c ./script-instalacion-pwsh.sh 
RUN rm script-instalacion-pwsh.sh

# script de Powershell para instalar las herramientas de Powershell básicas
COPY recursos-imagen/script-instalacion-modulos.ps1 .
RUN pwsh -NonInteractive -c ./script-instalacion-modulos.ps1

# gestionar las dependencias del proyecto, para que los módulos estén instalados al crear un contenedor a partir de ella
COPY Dependencias/* /Dependencias/
RUN pwsh -NonInteractive -c Invoke-PSDepend -Path /Dependencias -Force -ErrorAction Stop && rm -rf /Dependencias

WORKDIR /var/jenkins_home
USER jenkins