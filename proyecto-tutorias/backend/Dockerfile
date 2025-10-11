# Imagen base
FROM node:18-alpine

# Crear carpeta de trabajo
WORKDIR /app

# Copiar package.json e instalar dependencias
COPY package*.json ./
RUN npm install --production

# Copiar el resto del código
COPY . .

# Exponer puerto del backend (ajusta si usas otro)
EXPOSE 3000

# Comando por defecto
CMD ["node", "index.js"]
