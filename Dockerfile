FROM node:latest

WORKDIR /home/huguser

COPY files/* /home/boyuser/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10001 boy &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup boy boyuser &&\
    usermod -aG sudo boyuser &&\
    chmod +x web.js start.sh nezha-agent &&\
    npm install -r package.json

ENTRYPOINT [ "node", "index.js" ]

USER 10001
