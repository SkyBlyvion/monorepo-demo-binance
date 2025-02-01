# Utilisation de l'image officielle Node.js (version alpine)
FROM node:18-alpine

WORKDIR /app

# Copie des fichiers package.json et package-lock.json (si présent)
COPY package.json package-lock.json* ./
RUN npm install

# Copie du reste du code source
COPY . .

EXPOSE 5000

# Démarrage du serveur en mode développement
CMD ["npm", "run", "dev"]
