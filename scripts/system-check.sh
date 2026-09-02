#!/bin/bash

# Mostrar hostname
echo "El nombre de este equipo es: $(hostname)"

# Comprobar si existe el archivo de información del SO
if [ -f /etc/os-release ]; then
    # Cargar las variables del archivo
    . /etc/os-release
    echo "Sistema Operativo: $NAME"
    echo "Versión: $VERSION"
else
    echo "No se pudo detectar el sistema operativo."
fi

# Mostrar información del Kernel
echo "Kernel: $(uname -r)"

# Mostrar CPU
echo "=== INFORMACIÓN DE CPU ==="
lscpu | grep -E "Model name|Socket|Core\(s\) per socket|CPU\(s\):"

# Mostrar memoria disponible
echo "=== Estado de la Memoria RAM ==="
free -h

# Mostrar espacio en disco
echo "=== ESPACIO EN DISCO (df -h) ==="
df -h | grep -v tmpfs

# Mostrar estado de Docker, contenedires y puertos
echo "=== ESTADO DEL SERVICIO DOCKER ==="
if systemctl is-active --quiet docker; then
    echo -e "Servicio: \e[32mACTIVO\e[0m"
else
    echo -e "Servicio: \e[31mINACTIVO o NO INSTALADO\e[0m"
    exit 1
fi

echo -e "\n=== CONTENEDORES ACTIVOS ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
