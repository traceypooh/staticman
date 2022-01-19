FROM node:alpine

RUN apk add git  && \
    git clone https://github.com/eduardoboucas/staticman.git /app

WORKDIR /app

RUN cp config.sample.json  config.production.json  && \
    env  && \
    env |fgrep SEKRIT  && \
    echo xxx update config.production.json gitlabToken rsaPrivateKey  && \
    npm i

CMD [ "npm", "start" ]
