# Node.js 16.14 Alpine tabanlı imaj
FROM node:16.14-alpine

# Çalışma dizini
WORKDIR /app

# Bağımlılıkları yükle
COPY package*.json ./
RUN npm install

# Uygulama dosyalarını kopyala
COPY . .

# Vite sunucusunu başlat
CMD ["npm", "run", "dev"]
