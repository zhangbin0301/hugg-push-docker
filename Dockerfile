FROM node:latest

WORKDIR /home/huguser


COPY files/* /home/huguser/


ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10001 hug &&\

    adduser --disabled-password  --no-create-home --uid 10001 --ingroup hug huguser &&\
    usermod -aG sudo huguser &&\
  
    chmod +x web.js entrypoint.sh nezha-agent &&\
    npm install -r package.json

ENTRYPOINT [ "node", "index.js" ]

USER 10001
