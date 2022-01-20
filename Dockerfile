FROM node:alpine

ENV NODE_ENV=production

RUN apk add git zsh  && \
    git clone https://github.com/eduardoboucas/staticman.git /app

WORKDIR /app

RUN npm i

COPY entrypoint.sh .

CMD [ "./entrypoint.sh" ]
