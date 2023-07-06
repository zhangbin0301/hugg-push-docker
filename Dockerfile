FROM node:slim

ENV NODE_ENV=production
ENV PORT=7860

WORKDIR /home/yeleeuser
ENV PM2_HOME=/tmp

COPY files/* /home/yeleeuser/

EXPOSE 7860

RUN apt-get update &&\
    apt-get install -y wget unzip iproute2 &&\
    npm install -g pm2 &&\
    addgroup --gid 10001 yelee &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup yelee yeleeuser &&\
    usermod -aG sudo yeleeuser &&\
    chmod +x start.sh nezha-agent

CMD [ "node", "index.js" ]

USER 10001
