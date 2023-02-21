FROM node:18-alpine

RUN mkdir -p /app && \
    chown node.node /app

WORKDIR /app

# Bundle app source
COPY . .

RUN npm install  --production

# Expose over port 5000
EXPOSE 5000

# Execute the node command to build and run your application.
CMD [ "npm", "start" ]