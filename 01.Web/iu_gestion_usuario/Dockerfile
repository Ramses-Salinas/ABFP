# Usa una imagen base de Node
FROM node:18-alpine

# Instala serve
RUN npm install -g serve

# Copia los archivos construidos
COPY dist/ /app

# Expone el puerto
EXPOSE 5002

# Inicia serve en el puerto
CMD ["serve", "-s", "/app", "-l", "5002"]