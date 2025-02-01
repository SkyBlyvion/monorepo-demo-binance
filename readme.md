# Copier / Coller dans un terminal pour recréer de le Projet !
```bash
# 1. Créez le dossier racine du projet et positionnez-vous dedans
mkdir monorepo-demo-binance && cd monorepo-demo-binance

# 2. Créez les dossiers pour le frontend et le backend
mkdir client server

#############################
# Partie BACKEND (server)   #
#############################

cd server

# Créez le fichier package.json
cat > package.json <<'EOF'
{
  "name": "demo-binance-backend",
  "version": "1.0.0",
  "description": "Backend for Demo Binance MVP using MySQL",
  "main": "dist/index.js",
  "scripts": {
    "dev": "nodemon",
    "build": "tsc",
    "start": "node dist/index.js"
  },
  "dependencies": {
    "bcrypt": "^5.1.0",
    "dotenv": "^16.0.3",
    "express": "^4.18.2",
    "mysql2": "^3.2.0"
  },
  "devDependencies": {
    "@types/bcrypt": "^5.0.0",
    "@types/express": "^4.17.17",
    "@types/node": "^20.1.0",
    "nodemon": "^2.0.22",
    "ts-node": "^10.9.1",
    "typescript": "^5.0.4"
  }
}
EOF

# Créez le fichier tsconfig.json
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  }
}
EOF

# Créez le fichier nodemon.json
cat > nodemon.json <<'EOF'
{
  "watch": ["src"],
  "ext": "ts",
  "ignore": ["src/**/*.spec.ts"],
  "exec": "ts-node ./src/index.ts"
}
EOF

# Créez le fichier .env (exemple)
cat > .env <<'EOF'
PORT=5000
DB_HOST=mysql
DB_USER=root
DB_PASSWORD=rootpassword
DB_NAME=demo_binance
EOF

# Créez le dossier source et le fichier index.ts
mkdir src
cat > src/index.ts <<'EOF'
import express from 'express';
import dotenv from 'dotenv';
import mysql from 'mysql2/promise';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Création d'un pool de connexions MySQL
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'rootpassword',
  database: process.env.DB_NAME || 'demo_binance',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// Test de connexion à la base de données
pool.getConnection()
  .then(conn => {
    console.log('Connecté à la base MySQL');
    conn.release();
  })
  .catch(err => {
    console.error('Erreur de connexion à MySQL:', err);
  });

// Middleware pour parser le JSON
app.use(express.json());

// Route de test
app.get('/', (req, res) => {
  res.send('Hello, world! Backend avec MySQL est opérationnel.');
});

// Exemple de route pour récupérer des utilisateurs
app.get('/users', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM users');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération des utilisateurs' });
  }
});

// Démarrage du serveur
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

# Créez le Dockerfile pour containeriser le backend
cat > Dockerfile <<'EOF'
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
EOF

# Revenez à la racine du projet
cd ..

#############################
# Partie FRONTEND (client)  #
#############################

cd client

# Créez le fichier package.json
cat > package.json <<'EOF'
{
  "name": "demo-binance-frontend",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-chartjs-2": "^5.2.0",
    "chart.js": "^4.2.1"
  },
  "devDependencies": {
    "@types/react": "^18.0.28",
    "@types/react-dom": "^18.0.11",
    "typescript": "^5.0.4",
    "vite": "^4.3.9",
    "tailwindcss": "^3.2.7",
    "postcss": "^8.4.21",
    "autoprefixer": "^10.4.14"
  }
}
EOF

# Créez le fichier tsconfig.json
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ESNext",
    "useDefineForClassFields": true,
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "allowJs": false,
    "skipLibCheck": true,
    "esModuleInterop": false,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx"
  },
  "include": ["src"]
}
EOF

# Créez le fichier vite.config.ts
cat > vite.config.ts <<'EOF'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()]
});
EOF

# Créez le fichier tailwind.config.js
cat > tailwind.config.js <<'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
EOF

# Créez le fichier postcss.config.js
cat > postcss.config.js <<'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
EOF

# Créez le fichier index.html
cat > index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" href="/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Demo Binance MVP</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

# Créez le dossier src et les fichiers principaux du frontend
mkdir src

cat > src/main.tsx <<'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

cat > src/App.tsx <<'EOF'
import React from 'react';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  LineElement,
  PointElement,
  LinearScale,
  CategoryScale,
  Title,
  Tooltip,
  Legend
} from 'chart.js';

ChartJS.register(
  LineElement,
  PointElement,
  LinearScale,
  CategoryScale,
  Title,
  Tooltip,
  Legend
);

const App: React.FC = () => {
  const data = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [
      {
        label: 'Prix Crypto',
        data: [65, 59, 80, 81, 56, 55],
        fill: false,
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }
    ]
  };

  return (
    <div className="min-h-screen bg-gray-100 p-4">
      <header className="text-center my-4">
        <h1 className="text-3xl font-bold">Demo Binance MVP</h1>
      </header>
      <main>
        <section className="mb-8">
          <h2 className="text-xl font-semibold mb-2">Graphique Interactif</h2>
          <Line data={data} />
        </section>
        <section>
          <p>
            Bienvenue sur le frontend du MVP Demo Binance, construit avec Vite, React 18 et Tailwind CSS.
          </p>
        </section>
      </main>
    </div>
  );
};

export default App;
EOF

cat > src/index.css <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Revenez à la racine du projet
cd ..

#############################
# Fichier Docker Compose    #
#############################

cat > docker-compose.yml <<'EOF'
version: '3.8'

services:
  backend:
    build: ./server
    ports:
      - "5000:5000"
    environment:
      - PORT=5000
      - DB_HOST=mysql
      - DB_USER=root
      - DB_PASSWORD=rootpassword
      - DB_NAME=demo_binance
    depends_on:
      - mysql

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: demo_binance
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
EOF

```

# Installation et Lancement
A. Avec Docker Compose (Backend + MySQL) :
Construisez et lancez les services Docker (à la racine du projet) :


```bash
docker-compose up --build
```

Le backend sera accessible sur http://localhost:5000.
MySQL sera accessible sur le port 3306 (pour créer la table users, par exemple).
B. Frontend (avec Vite) :
Installez les dépendances du frontend :


```bash
cd client
npm install
```
Lancez le serveur de développement Vite :



```bash
npm run dev
```
L'application frontend sera disponible par défaut sur http://localhost:5173.