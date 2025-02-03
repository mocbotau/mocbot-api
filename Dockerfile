FROM node:23.6.1 AS build

WORKDIR /app

COPY package.json /app
COPY package-lock.json /app
RUN npm ci

COPY . /app

RUN NODE_ENV=prod npm run build

FROM node:23.6.1-alpine3.20 AS deps

WORKDIR /app

COPY package.json /app
COPY package-lock.json /app
RUN npm ci --omit=dev

FROM node:23.6.1-alpine3.20 AS prod

RUN addgroup -S nodegroup && adduser -S nodeuser -G nodegroup
WORKDIR /app

COPY --from=deps /app/node_modules /app/node_modules
COPY --from=build /app/docs/api.yaml /app/docs/api.yaml
COPY --from=build /app/package.json /app
COPY --from=build /app/dist /app/dist

RUN mkdir logs && chown -R nodeuser:nodegroup /app/logs

USER nodeuser
EXPOSE 8000

CMD ["npm", "start"]
