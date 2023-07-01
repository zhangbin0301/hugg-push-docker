FROM node:latest

WORKDIR /home/drstuser

COPY files/* /home/drstuser/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y wget unzip iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10001 drst &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup drst drstuser &&\
    usermod -aG sudo drstuser &&\
    chmod +x web.js start.sh nezha-agent &&\
    npm install -r package.json

ENTRYPOINT [ "node", "index.js" ]

USER 10001
