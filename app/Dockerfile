FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
# run npm ci --production to ensure that exact versions are installed from package-lock.json
RUN npm ci --production 
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]