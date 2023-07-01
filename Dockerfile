FROM node:latest

# WORKDIR /home/huguser
WORKDIR /home/myuser

# COPY files/* /home/huguser/
COPY files/* /home/myuser/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
   # addgroup --gid 10001 hug &&\
    addgroup --gid 10001 my &&\
   # adduser --disabled-password  --no-create-home --uid 10001 --ingroup hug huguser &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup my myuser &&\
   # usermod -aG sudo huguser &&\
    usermod -aG sudo myuser &&\
    chmod +x web.js entrypoint.sh nezha-agent &&\
    npm install -r package.json

ENTRYPOINT [ "node", "index.js" ]

USER 10001
