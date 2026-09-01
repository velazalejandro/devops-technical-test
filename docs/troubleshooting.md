## Incidencia 1. Jenkins muestra: docker: command not found. ¿Qué comprobarías y cómo lo solucionarías?
Solución: Primero comprobaría si Docker está instalado en el servidor donde se ejecuta Jenkins:
docker --version
which docker

Si Docker está instalado, comprobaría que el ejecutable está disponible en el PATH del usuario con el que se ejecuta Jenkins:
sudo -u jenkins which docker
sudo -u jenkins docker --version

También comprobaría el servicio de Docker mediante systemctl status.

Si el ejecutable existe pero Jenkins no lo encuentra, revisaría la configuración del PATH y la configuración de herramientas de Jenkins en Manage Jenkins - Tools (Global Tool Configuration).

Por último, comprobaría los permisos del usuario jenkins para comunicarse con Docker. Si es necesario, añadiría el usuario jenkins al grupo docker y reiniciaría el servicio de Jenkins:
sudo usermod -aG docker jenkins




## Incidencia 2. La imagen Docker se construye correctamente, pero curl http://localhost:8080/health devuelve Connection refused. Indica los pasos y comandos que utilizarías para localizar el problema.
Solución: 
Primero comprobaría si el contenedor está ejecutándose:
docker ps

Si no aparece, comprobaría los contenedores detenidos:
docker ps -a


Si el contenedor se ha detenido, revisaría sus logs:
docker logs <container_id>


También comprobaría el estado del contenedor:
docker inspect <container_id>


A continuación, comprobaría que el puerto 8080 está correctamente publicado en el host:
docker ps


Por ejemplo, debería aparecer un mapeo similar a:
0.0.0.0:8080->8080/tcp


Si no existe el mapeo, revisaría cómo se ha iniciado el contenedor y utilizaría la opción -p correspondiente, por ejemplo:
docker run -p 8080:8080 <imagen>


Después comprobaría qué puertos están escuchando en el sistema:
ss -lntp


También comprobaría desde dentro del contenedor si la aplicación está escuchando en el puerto esperado:
docker exec -it <container_id> ss -lntp


Si la aplicación está escuchando dentro del contenedor, pero no se puede acceder desde el host, revisaría el mapeo de puertos y la configuración de red de Docker.

Finalmente, probaría el endpoint desde el propio contenedor para determinar si el problema está en la aplicación o en la comunicación entre el host y el contenedor:
docker exec <container_id> curl http://localhost:8080/health



## Incidencia 3. El pipeline funcionaba correctamente ayer, pero hoy falla al descargar una dependencia. ¿Qué revisarías antes de modificar el pipeline?
Solución: Revisaría los logs de la última ejecución de la pipeline en Jenkins para poder identificar el error exacto. Buscaría el mensaje de error concreto, la dependencia afectada y el repositorio desde el que se intenta descargar. Sobre el repositorio comprobaría si está disponible y su versión por si ha cambiado.



## Incidencia 4. El despliegue se completa, pero la nueva versión no funciona correctamente. Explica cómo realizarías un rollback de forma segura.
Solución: Revisaría los logs de la aplicación para determinar que es necesario realizar un rollback.

Antes de ejecutarlo, identificaría la versión actualmente desplegada y la última versión estable, comprobando que la versión anterior está disponible y que tenemos una forma segura de restaurarla.

Realizaría el rollback utilizando el mecanismo de despliegue habitual, evitando realizar cambios manuales directamente en producción.

Después del rollback:
Comprobaría que los servicios y contenedores están funcionando correctamente.
Revisaría los logs para confirmar que no aparecen nuevos errores.
Comprobaría las métricas y el estado del servicio.
Mantendría monitorizado el sistema durante un periodo de tiempo para asegurar que la versión anterior funciona correctamente.

Finalmente documentaría el rollback indicando la versión afectada, la versión restaurada, el motivo y los resultados de las comprobaciones.


## Incidencia 5. Un desarrollador te comunica: “Mi pipeline falla, pero en local funciona”. Describe brevemente cómo abordarías la incidencia.
Solución: Revisaría los logs de la ejecución de Jenkins para poder saber donde falla el pipeline.
Comprobaría la versión de las herramientas, la versión de las dependencias, variables, permisos y conectividad. También revisaría el código que funciona en modo local.
