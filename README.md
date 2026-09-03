# prueba-devops

## Arquitectura


## Requisitos
Software utilizado para la ejecución de las pruebas:
- VirtualBox para la preparación del entorno y una imagen Ubuntu 20.04.1 para la instalación del sistema.
- Terminal de comandos de Ubuntu para la ejecución de los comandos, instalaciones y creación de archivos.
- Git y GitHub para gestionar el repositorio, alojar el contenido y realizar los cambios necesarios.
- Lenguajes Python y Flask para el desarrollo y despliegue de la aplicación web.
- Docker y docker-compose para la creación de imagen y construcción de la aplicación.
- Jenkins para automatizar el despliegue de la aplicación mediante una serie de pasos.
- Kubernetes para automatizar el despliegue, el escalado y la gestión de la aplicación en contenedores.


## Instalación


## CI/CD


## Troubleshooting
Hace referencia al documento de incidencias alojado en el directorio "docs".

## Kubernetes


## Security considerations
La seguridad se tiene en cuenta durante el proceso de CI/CD y el despliegue de la aplicación.

### Credenciales de Jenkins

Las credenciales utilizadas por Jenkins se almacenan mediante el sistema de credenciales de Jenkins y no en el Jenkinsfile ni en el repositorio.


### Credenciales de Docker Registry

Las credenciales utilizadas para autenticarse contra Docker Hub se almacenarán como credenciales de Jenkins. No se incluirán usuarios, contraseñas ni tokens en el código fuente o en el Jenkinsfile. La autenticación se realizará únicamente en las fases que necesiten realizar docker login o docker push.

### Variables sensibles

Las variables que contengan información sensible, como contraseñas, tokens o secrets, no se almacenarán en el repositorio.
Se utilizarán credenciales gestionadas por Jenkins o variables de entorno. Además, se evitaría mostrar estos valores en los logs de las pipelines.

### Secrets en Kubernetes

### Acceso SSH a servidores

El acceso SSH a servidores de despliegue se realizará mediante claves SSH gestionadas de forma segura, almacenando las claves privadas en Jenkins Credentials. Se evitaría utilizar contraseñas en scripts y se limitarían los permisos de las claves al mínimo necesario para realizar el despliegue.


### Permisos del usuario que ejecuta Jenkins

El usuario que ejecuta Jenkins debe disponer únicamente de los permisos necesarios para realizar las tareas de CI/CD. En este proyecto, si Jenkins necesita utilizar Docker, se configurará el acceso necesario al servicio Docker.


### Rotación de credenciales

Las contraseñas, tokens y claves utilizadas por Jenkins deben renovarse en un cierto periodo de tiempo. Al realizar la rotación, se actualizará la credencial almacenada en Jenkins sin necesidad de modificar el código fuente del proyecto.



## Uso de IA


## Mejoras
