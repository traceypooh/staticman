FROM node:alpine

RUN apk add git bash  && \
    git clone https://github.com/eduardoboucas/staticman.git /app

WORKDIR /app

RUN npm i

CMD [ "./entrypoint.sh" ]
