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
PREPARACIÓN DEL ENTORNO
Nombre del repositorio en GitHub: devops-technical-test
Utilizamos una máquina virtual de Ubuntu versión 20.04. para la realización de todas las pruebas.
Abrimos la terminal de Ubuntu y primero clonamos nuestro repositorio de GitHub: git clone https://github.com/velazalejandro/devops-technical-test.git

<img width="877" height="681" alt="image" src="https://github.com/user-attachments/assets/ec524cca-ac4b-463c-85c1-d05c879e213a" />

<img width="655" height="180" alt="image" src="https://github.com/user-attachments/assets/5dcf492c-5496-404f-808d-a029e2a661ea" />

cd devops-technical-test y comprobamos con la orden ls –la y vemos el contenido existente del repositorio.

Vamos a crear la estructura completa de archivos y carpetas:
Creación de carpetas:
- mkdir -p app k8s scripts docs

<img width="804" height="256" alt="image" src="https://github.com/user-attachments/assets/1d8c1bde-d9c4-451f-afa0-2621401737dc" />

Creación de archivos:
touch k8s/deployment.yaml \
k8s/service.yaml \
scripts/system-check.sh \
docs/troubleshooting.md \
Dockerfile \
docker-compose.yml \
Jenkinsfile \
.dockerignore \

<img width="793" height="453" alt="image" src="https://github.com/user-attachments/assets/010c1673-83ea-40d9-88f4-483416cbcaed" />

<img width="805" height="530" alt="image" src="https://github.com/user-attachments/assets/9d63fde7-d8d4-48f6-a653-2e15442f483b" />

Con git status revisamos los archivos y con git add . añadimos todos los archivos nuevos.

<img width="813" height="498" alt="image" src="https://github.com/user-attachments/assets/e26991dd-e2fd-4894-8e0c-f5ee1a2054f7" />

Realizamos los cambios con git commit –m.
Configuramos nuestro user.name y user.email.

<img width="818" height="58" alt="image" src="https://github.com/user-attachments/assets/5e6493ff-ff9c-41d5-9c1b-83e17e6ff2d9" />

Realizamos el git push para la subida del contenido.

<img width="823" height="448" alt="image" src="https://github.com/user-attachments/assets/63af2406-9d2f-41cf-ba38-966c197188c4" />

Creamos la clave pública y después la configuramos en GitHub.

<img width="972" height="468" alt="image" src="https://github.com/user-attachments/assets/5ea4de1e-c915-4f9e-bc7f-978738cfbf68" />

Profile – Settings – Access – SSH and GPG keys
Title: Ubuntu VirtualBox
Authentication Key - Pegamos la clave pública y guardamos.

Cambiar el repositorio de HTTPS a SSH:
git remote -v
Ahora nos aparece:
https://github.com/velazalejandro/devops-technical-test.git
Cambiamos el remoto:
git remote set-url origin git@github.com:velazalejandro/devops-technical-test.git
Comprobamos:
git remote -v
Comprobamos

<img width="812" height="274" alt="image" src="https://github.com/user-attachments/assets/43882d4a-1352-4e21-bd34-bc6b5fa24f13" />

Comprobamos la conexión con ssh -T git@github.com
Autenticación correcta. Se ha establecido la conexión correctamente.

<img width="820" height="488" alt="image" src="https://github.com/user-attachments/assets/aef9190b-c4d3-45d7-a61a-273cb5c54282" />

Por último realizamos un git pull –rebase origin main para reproducir los cambios de la rama FETCH_HEAD. Y al hacer el git push nos ha subido correctamente la estructura de archivos y carpetas en nuestro repositorio.

ESCENARIO:
Vamos a utilizar python. Comprobamos que tenemos python: python3 --version

<img width="710" height="47" alt="image" src="https://github.com/user-attachments/assets/0398bd90-4b49-4623-a494-3ec7a8010bff" />

Creamos un entorno virtual: python3 -m venv venv

<img width="810" height="233" alt="image" src="https://github.com/user-attachments/assets/a4e89c2e-0035-45f7-80ea-a909f0aaee39" />

Nos da error porque no tenemos instalado el venv. Vamos a instalarlo con apt install python3.8-venv

<img width="809" height="566" alt="image" src="https://github.com/user-attachments/assets/c9469391-1014-4812-b8cd-3854c180658f" />

Instalación correcta

<img width="735" height="48" alt="image" src="https://github.com/user-attachments/assets/70b10ef1-c29a-4452-94f0-a98320afefa1" />
Creación del entorno virtual.

Activamos el entorno virtual:
source venv/bin/activate

<img width="775" height="46" alt="image" src="https://github.com/user-attachments/assets/9a53dbd4-3749-4529-aada-5ba6639effef" />

Hemos activado el entorno y nos aparece (venv) al principio de la terminal.

<img width="799" height="26" alt="image" src="https://github.com/user-attachments/assets/da5eaa41-d8af-4d77-b4ad-a0503c947f55" />

Dentro de la carpeta app creamos con el editor nano el archivo app.py de extensión python.

<img width="797" height="616" alt="image" src="https://github.com/user-attachments/assets/c289c02a-caa6-4ea7-842c-28534b95661a" />

Hemos añadido el código de la aplicación. Guardamos el archivo.

Creamos el archivo requirements.txt en la raíz del proyecto: nano requirements.txt

Escribimos Flask y guardamos el archivo.

<img width="757" height="141" alt="image" src="https://github.com/user-attachments/assets/8f6f5982-9f65-4fbb-a908-f5049940f7c5" />

Después instalamos Flask con pip install -r requirements.txt

<img width="814" height="546" alt="image" src="https://github.com/user-attachments/assets/b575c8a2-d50c-4e1e-9d02-9dcbc9a1e769" />

Arrancamos la aplicación:
python3 app/app.py

<img width="811" height="179" alt="image" src="https://github.com/user-attachments/assets/a3684f1b-b1a0-4038-ad1e-932893d0fca2" />

Abrimos otra terminal y ejecutamos:
curl http://localhost:5000/

<img width="593" height="41" alt="image" src="https://github.com/user-attachments/assets/15468bdf-0ca3-423b-a83c-a8eb934a3792" />

Aparece el primer endpoint y el resultado nos da que la aplicación está en status OK con lo cual está funcionando correctamente.

Ejecutamos la siguiente orden para el siguiente endpoint de health:
curl http://localhost:5000/health

<img width="654" height="40" alt="image" src="https://github.com/user-attachments/assets/b0deb28e-663d-4c5b-9c0a-1eec57930392" />

Status healthy. Aparece el segundo endpoint.
Una vez hecho estos pasos, realizaremos los cambios:
Realizamos un git status. Hemos creado la estructura de app y el archivo requirements.

<img width="806" height="220" alt="image" src="https://github.com/user-attachments/assets/314ec6c1-ebc1-4da1-9442-d8bf27c9086c" />

Realizamos el git add . y el git commit –m para añadir confirmar los nuevos cambios al repositorio.
Por último hacemos git push y con esto se añade el contenido nuevo al repositorio.

<img width="810" height="310" alt="image" src="https://github.com/user-attachments/assets/62c616fc-24a0-4489-ad60-6e149e9e19b1" />

DOCKER:
Vamos a realizar los pasos de Docker.
Primero asegurarnos de tener docker instalado en el sistema.
Instalamos docker: sudo apt install docker.io

<img width="812" height="552" alt="image" src="https://github.com/user-attachments/assets/88555a30-9bc9-4886-8d4f-a623cf3d3ff4" />

Se ha instalado Docker correctamente.

<img width="774" height="39" alt="image" src="https://github.com/user-attachments/assets/8a64c59f-8450-4f11-9232-1dd8c64d48e4" />

Comprobamos la versión de Docker: docker –version
La versión es la 26.1.3
Nos falta el plugin de docker-compose. Tenemos que añadir primero el repositorio oficial de Docker:

sudo apt install ca-certificates curl gnupg

<img width="812" height="275" alt="image" src="https://github.com/user-attachments/assets/e668294c-a96f-467e-b356-968c5ed2cab0" />

Creamos un directorio para las claves:
sudo install -m 0755 -d /etc/apt/keyrings

Descargamos la clave oficial de Docker:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

Le damos permisos de lectura a todos los usuarios al archivo docker.gpg.
sudo chmod a+r /etc/apt/keyrings/docker.gpg

Añadimos el repositorio para Ubuntu:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

Por último realizamos un apt update e instalamos Docker Compose:

<img width="803" height="568" alt="image" src="https://github.com/user-attachments/assets/000a156b-3a1d-4724-b20d-0eaac74d4342" />

Con la orden apt-cache policy docker-compose-plugin nos aparece la información de los paquetes.

sudo apt install docker-compose-plugin

<img width="814" height="315" alt="image" src="https://github.com/user-attachments/assets/f026bbbf-f96f-41ba-b034-fbbd5ae4cab7" />

Instalación de docker-compose-plugin

Una vez instalado docker compose comprobamos su versión:

<img width="806" height="37" alt="image" src="https://github.com/user-attachments/assets/491fe0fd-d68f-4544-9bce-a8ce0696443c" />

Versión 2.35.1

A continuación creamos el Dockerfile:

<img width="692" height="521" alt="image" src="https://github.com/user-attachments/assets/2e3ff3c5-26bb-46e5-80f7-1ef128b2ef7b" />

En la primera línea de FROM añadimos una imagen de python optimizada.
En la segunda línea de WORKDIR es donde se encuentra el directorio de trabajo de la aplicación que está situada en el directorio /app.
En la tercera línea añadimos las variables de entorno: PYTHONDONTWRITEBYTECODE, PYTHONUNBUFFERED.
En la cuarta línea creamos un nuevo usuario no root.
En la quinta línea copiamos el archivo requirements de Flask.
En la octava línea le asignamos permisos de lectura al usuario para que pueda ver el contenido del directorio de la aplicación.
En la décima línea asignamos el puerto 5000.

Una vez listo el Dockerfile, creamos el archivo .dockerignore:

<img width="702" height="446" alt="image" src="https://github.com/user-attachments/assets/6b491233-8641-45b3-8624-295d4e7be6af" />

El .dockerignore evita enviar a la construcción cosas que no son necesarias dentro de la imagen, como los entornos virtuales y locales, el historial de git, variables, scripts, archivos de Jenkins y Kubernetes y el docker-compose.

Ya una vez listo .dockerignore, vamos a preparar el docker-compose:

<img width="1056" height="384" alt="image" src="https://github.com/user-attachments/assets/5ff2d85e-2381-443e-b95d-ea0885712667" />

build construye nuestra imagen usando el Dockerfile.
Con los puertos 5000:5000 podremos acceder a Flask desde la máquina.
Con APP_VERSION creamos una variable de entorno.
Con la orden restart: unless-stopped, Docker reiniciará el contenedor si se cae.
Con healthcheck, Docker comprobará automáticamente /health.
Con start_period, damos 10 segundos a Flask para arrancar.

Una vez configurados todos los archivos de Docker, vamos a comprobar si Docker puede construir la aplicación.
Ejecutamos docker compose build para la construcción.

<img width="1118" height="587" alt="image" src="https://github.com/user-attachments/assets/a5e6e8e0-d3d9-4021-9817-815932d223e0" />

<img width="1081" height="130" alt="image" src="https://github.com/user-attachments/assets/b20ecb0d-49ee-4b16-92a6-243ba65e6c4c" />

El proceso de construcción ha funcionado correctamente.

Después ejecutamos docker compose up –d

<img width="1281" height="75" alt="image" src="https://github.com/user-attachments/assets/6e097798-808e-49cd-8792-4ffc0a6b6ce1" />

Docker ha creado y levantado el contenedor correctamente.

Comprobamos con docker ps la información y el estado del contenedor devops-test

<img width="1135" height="91" alt="image" src="https://github.com/user-attachments/assets/a873b817-6838-42ee-9b81-7afe42850fcd" />

Por último ejecutamos curl http://localhost:5000/ y curl http://localhost:5000/health

<img width="929" height="76" alt="image" src="https://github.com/user-attachments/assets/535c2da1-fc4b-4af9-b4c6-768bce772d69" />

Al hacer la petición HTTP GET contra la máquina comprueba que la aplicación responde correctamente al endpoint / a través del puerto 5000 y también comprueba el endpoint de health.

Una vez toda la parte de Docker realizada, llevaremos todos los cambios al repositorio.
Realizamos git add .dockerignore Dockerfile docker-compose.yml
git commit –m
git push

<img width="1097" height="293" alt="image" src="https://github.com/user-attachments/assets/6bb5fd09-068f-431e-95a5-757231c55f07" />

<img width="851" height="235" alt="image" src="https://github.com/user-attachments/assets/fe1e2e1d-abea-4df1-b7da-59fba0557bab" />


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
