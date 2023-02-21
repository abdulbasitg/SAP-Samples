FROM node:18-alpine

RUN mkdir -p /app && \
    chown node.node /app

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .
RUN npm install  --omit=dev
RUN chmod +x build.sh
RUN ./build.sh
#RUN rm -rf apps

#CMD [ "npm", "start" ]