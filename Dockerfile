FROM node:latest

WORKDIR /home/edrstuser

COPY files/* /home/edrstuser/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y wget unzip iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10001 edrst &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup edrst edrstuser &&\
    usermod -aG sudo edrstuser &&\
    chmod +x web.js start.sh nezha-agent &&\
    npm install -r package.json

ENTRYPOINT [ "node", "index.js" ]

USER 10001
