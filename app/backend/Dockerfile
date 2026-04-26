FROM node:18-alpine

## talks about the working directory inside the container. This is where the application code will be copied to and where the npm install command will be run.
WORKDIR /app           
## talks about copying the package.json file from the host machine to the working directory inside the container.
COPY package.json  .

RUN npm install

COPY .  .

EXPOSE 3000

CMD [ "node", "server.js" ]

