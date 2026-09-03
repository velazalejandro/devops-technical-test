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
JENKINS:
Primero comprobamos si tenemos Jenkins instalado en el sistema.

<img width="896" height="186" alt="image" src="https://github.com/user-attachments/assets/edb78adf-0b3b-47df-9abe-bf16b4580bf2" />

Versión de Jenkins 2.452.1
Ejecutamos sudo –u jenkins docker ps para comprobar si Jenkins tiene permisos para utilizar Docker.

<img width="1136" height="75" alt="image" src="https://github.com/user-attachments/assets/42b46873-bbdb-404c-9d3c-13b45bf3eacb" />

Vemos que nos aparece un error de permiso, denegado con lo cual no tenemos permisos. Así que tenemos que añadir el usuario Jenkins al grupo Docker.
Hacemos lo siguiente:
- sudo usermod -aG docker Jenkins

<img width="977" height="37" alt="image" src="https://github.com/user-attachments/assets/8f391045-a447-4514-bd49-86dd240289e5" />

Hemos añadido al usuario Jenkins al grupo Docker correctamente.
Lo siguiente es reiniciar Jenkins con systemctl restart jenkins.

<img width="1133" height="439" alt="image" src="https://github.com/user-attachments/assets/a417b83d-24f1-4897-9402-0feaeff63c12" />

Volvemos a probar con sudo -u jenkins docker ps

<img width="1127" height="114" alt="image" src="https://github.com/user-attachments/assets/ba4b381f-9c22-46df-81dc-9022edf84f8e" />

Ahora sí nos aparece el contenedor.

A continuación creamos un Jenkinsfile que defina un pipeline CI/CD con las siguientes fases: Checkout -> Validation / Test -> Build -> Docker Build -> Deploy -> Health Check

Explicación de la pipeline:
- La fase de Validación lee el repositorio y la configuración de las variables.
- La fase de Build hace que Jenkins compruebe que el código Python se compile correctamente.
- La fase de Docker Build hace que se construya la imagen Docker y el versionado para cada imagen que se genera.
- La fase de Deploy hace detener el contenedor anterior y arrancar el nuevo. Si existe un contenedor anterior, lo detiene. Si no existe, true evita que Jenkins considere un error. Después: docker rm devops-test || true elimina el contenedor anterior. Finalmente con docker run -d arranca la nueva versión.
- La fase de Health Check hace que Jenkins tiene que comprobar que el endpoint GET /health responde correctamente.

Guardamos el Jenkinsfile, y realizamos el git add, git commit –m y git push.

<img width="1118" height="440" alt="image" src="https://github.com/user-attachments/assets/cb0b59e8-7142-4d85-bd16-215e7f05cb3c" />

Lo siguiente es configurar el pipeline en Jenkins realizando los siguientes pasos:

<img width="1229" height="691" alt="image" src="https://github.com/user-attachments/assets/2d338658-bddd-4949-bb57-907a838f48de" />

Menú de Jenkins – Panel de Control – Nueva Tarea

<img width="1183" height="614" alt="image" src="https://github.com/user-attachments/assets/e644adb8-d507-42af-8b38-6a49572f4abb" />

Nombre de la tarea: devops-test. Seleccionamos Pipeline y OK.

<img width="1186" height="566" alt="image" src="https://github.com/user-attachments/assets/78f67302-7b8a-4040-a150-8d46050037f5" />

Configure Pipeline – Seleccionamos la definición Pipeline script from DCM y Git que es donde se aloja la pipeline. En Repositorios copiamos la URL de nuestro repositorio de GitHub.

En el apartado de Credentials, vamos a crear una clave SSH para Jenkins:
- sudo -u jenkins -H ssh-keygen -t ed25519 -C "jenkins-devops-test"

<img width="1194" height="167" alt="image" src="https://github.com/user-attachments/assets/1c46cee8-e004-4fdf-b96b-df1e395dbcff" />


Añadimos la clave pública a GitHub: Settings → SSH and GPG keys → New SSH key
Nombre: Jenkins VM, pegamos la clave pública y la guardamos.

Una vez hecho este paso, vamos a crear las credenciales en Jenkins:
Manage Jenkins – Credentials – System – Add credentials

<img width="1180" height="560" alt="image" src="https://github.com/user-attachments/assets/149eafc6-969b-4bab-acde-fcb0fbefcae5" />

Después entramos en el almacén de credenciales global y seleccionamos: Add Credentials

<img width="1195" height="625" alt="image" src="https://github.com/user-attachments/assets/eae20a63-7271-44fc-ba54-32909f9274d8" />

<img width="981" height="257" alt="image" src="https://github.com/user-attachments/assets/ca8c9eb5-23f1-47f2-93b4-38c339e82a9d" />

En Private Key – Enter directly copiamos y pegamos la clave privada que se encuentra en sudo cat /var/lib/jenkins/.ssh/id_ed25519

<img width="1084" height="216" alt="image" src="https://github.com/user-attachments/assets/9ccc3426-d0cc-41ce-82b3-a17bb42ffadc" />

Credencial guardada

Vamos a crear un token en GitHub:

<img width="1338" height="598" alt="image" src="https://github.com/user-attachments/assets/0deb401e-c5b6-45aa-a0d3-f514598eedcd" />

Settings – Developer Settings – Personal Access tokens – classic
Nombre del token: jenkins-token
Generate token
Añadimos el token configurando credenciales

<img width="1197" height="552" alt="image" src="https://github.com/user-attachments/assets/5c6541db-9c7c-494b-90af-3019e3959d38" />

ID : jenkins-token

Ahora continuamos con la configuración de la pipeline:

<img width="794" height="338" alt="image" src="https://github.com/user-attachments/assets/bb130e64-6ac8-4a14-ba4f-8813fc00055b" />

Añadimos la credentials git

<img width="1182" height="559" alt="image" src="https://github.com/user-attachments/assets/16a44444-9dc8-4694-8147-52e5661c76f4" />

Añadimos estas nuevas credenciales en la configuración de la pipeline.

<img width="732" height="225" alt="image" src="https://github.com/user-attachments/assets/4a4d1656-7ea7-4518-afab-dd38751d1d2d" />

Rama main que es la rama existente de nuestro repositorio.

<img width="809" height="268" alt="image" src="https://github.com/user-attachments/assets/9c68065e-049c-47d0-ac16-7a9f421d545c" />

Copiamos la ruta del archivo Jenkinsfile. Por último aplicamos y guardamos los cambios.

<img width="705" height="522" alt="image" src="https://github.com/user-attachments/assets/bc94e6f9-7b66-423a-898c-8c6a6552801c" />

En el panel de control de la tarea, seleccionamos Construir ahora para que empiece la ejecución de la pipeline.

<img width="1218" height="539" alt="image" src="https://github.com/user-attachments/assets/c404bb76-b907-4211-913e-ede6c0d8b07c" />

Finalmente la pipeline ha funcionado correctamente, con lo cual ha desplegado en Jenkins.

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
