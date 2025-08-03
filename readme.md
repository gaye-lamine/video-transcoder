##  Fonctionnalités

  

- Transcode automatiquement une vidéo `.mp4` en 1080p, 720p et 480p avec FFmpeg.

- Upload automatique des fichiers vers un bucket S3 compatible.

- Configuration simple via fichier `.env`.

- Tout fonctionne avec une seule commande Docker.

  

---

  

##  Prérequis

  

- Docker installé : https://docs.docker.com/get-docker/

- Un bucket S3 existant (AWS S3, Wasabi, Cloudflare R2…)

- Une clé d’accès (Access Key + Secret Key)

  

---

  

##  Configuration

  

Créer un fichier `.env` à la racine du projet :

 

AWS_ACCESS_KEY_ID=ton_access_key

AWS_SECRET_ACCESS_KEY=ton_secret_key

S3_BUCKET=nom_du_bucket

S3_ENDPOINT_URL=https://s3.eu-central-1.wasabisys.com

  

Exemple pour Wasabi : https://s3.eu-central-1.wasabisys.com

Exemple pour Cloudflare R2 : https://<accountid>.r2.cloudflarestorage.com

  

##  Utilisation

  

### 1. Place une vidéo `.mp4` dans le dossier `input/`.

  

Exemple de fichier : `input/video.mp4`

  

---

  

### 2. Build de l’image Docker

  



docker build -t ffmpeg-uploader .



docker run --rm \

--env-file .env \

-v "$(pwd)/input":/input \

-v "$(pwd)/output":/output \

ffmpeg-uploader

