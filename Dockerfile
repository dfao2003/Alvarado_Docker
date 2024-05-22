#Imagen base de ubuntu
FROM ubuntu:latest

#Imagen del nodeJS
FROM node:latest AS nodeS

#Proceso Angular
WORKDIR /PruebaDocker/frontend
COPY frontend/ /PruebaDocker/frontend/

#Instalación de npm
RUN npm install --force
RUN npm run build --prod
RUN npm install


# Instalación de la imgen ngix
FROM nginx:1.17.1-alpine

#Instalación de node js
RUN apk add --update nodejs npm

#Informacion del angular 
COPY --from=nodeS /PruebaDocker/frontend/dist/frontend/browser /usr/share/nginx/html

# Ejecución
CMD ["sh", "-c", "nginx -g 'daemon off;'"]

#Exposción del puerto 80 para nginx
EXPOSE 80



