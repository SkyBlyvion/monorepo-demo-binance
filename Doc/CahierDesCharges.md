# Cahier des Charges – Demo Binance MVP

## 1. Contexte et Objectifs

### Contexte
Développer une plateforme d’entraînement pour débutants souhaitant se familiariser avec le trading de cryptomonnaies. Le MVP simule quelques fonctionnalités essentielles d’une plateforme de trading (type Binance) sans interaction réelle avec de l’argent ou des tiers.

### Objectifs du MVP
- Permettre aux utilisateurs d’accéder à une interface simple pour observer les tendances des cryptomonnaies via des graphiques interactifs.
- Simuler des opérations de trading en utilisant un compte fictif.
- Fournir une base évolutive qui pourra être enrichie ultérieurement (authentification avancée, module premium, tutoriels, etc.).

## 2. Fonctionnalités

### 2.1. Backend

#### API Express
- Création d’un serveur HTTP avec Node.js et Express.
- Gestion des routes pour tester la connectivité et pour récupérer des données (exemple de route `/users`).

#### Base de Données
- Utilisation de MySQL (via le package mysql2) pour stocker les données.
- Exemple de table `users` pour la démonstration (base `demo_binance`).

#### Configuration et Dépendances
- **Langage** : TypeScript pour bénéficier d’un typage fort.
- **Dépendances principales** :
  - `express` (serveur web)
  - `dotenv` (gestion des variables d’environnement)
  - `mysql2` (connexion à MySQL)
  - `bcrypt` (hachage de mots de passe, en vue d’évolutions futures)
- **Outils de développement** :
  - `nodemon` (redémarrage automatique en mode développement)
  - `ts-node` et `typescript` pour compiler et exécuter le code TypeScript.

#### Containerisation
- Le backend est containerisé à l’aide d’un Dockerfile.
- Utilisation de Docker Compose pour lancer simultanément le backend et une instance MySQL.

### 2.2. Frontend

#### Interface Utilisateur
- Utilisation de React 18 pour construire une interface réactive et moderne.
- Mise en place d’un graphique interactif (avec Chart.js via react-chartjs-2) pour simuler le suivi des prix des cryptomonnaies.

#### Stack de développement Frontend
- **Outil de build** : Vite (offrant des temps de démarrage très rapides).
- **Langage** : TypeScript.
- **Framework CSS** : Tailwind CSS pour un design moderne et responsive.

#### Dépendances Frontend
- **Dépendances principales** :
  - `react` et `react-dom`
  - `react-chartjs-2` et `chart.js` (pour les graphiques)
- **Dépendances de développement** :
  - `vite`
  - `tailwindcss`, `postcss` et `autoprefixer`
  - Types pour React et Vite (`@types/react`, `@types/react-dom`)
  - Plugin React pour Vite : `@vitejs/plugin-react`

## 3. Architecture du Projet

Le projet adopte une structure monorepo avec deux dossiers principaux :

```bash
monorepo-demo-binance/
├── client          # Frontend (React 18, Vite, Tailwind CSS, Chart.js)
└── server          # Backend (Express, TypeScript, MySQL, Docker)
```

### Backend
Dossier `server/` :
- `package.json` avec les dépendances et scripts (exécution en mode dev via `nodemon`).
- `tsconfig.json` pour la configuration TypeScript.
- `nodemon.json` pour surveiller le dossier `src` et redémarrer le serveur lors de modifications.
- Fichier `.env` pour la configuration (port, connexion MySQL).
- Le code source se trouve dans le dossier `src/` (fichier principal `index.ts`).
- Un `Dockerfile` permet la containerisation du backend.

### Frontend
Dossier `client/` :
- `package.json` définissant les scripts de développement et build (via `Vite`).
- `tsconfig.json` pour la configuration TypeScript.
- Fichier de configuration Vite (`vite.config.ts`).
- Fichiers de configuration Tailwind et PostCSS (`tailwind.config.js`, `postcss.config.js`).
- Un fichier HTML de base (`index.html`).
- Le code source (React) dans le dossier `src/` (ex. `main.tsx`, `App.tsx` et `index.css`).

### Orchestration avec Docker Compose
Un fichier `docker-compose.yml` permet de lancer :
- Le service backend (via le `Dockerfile` dans `server/`)
- Le service MySQL (avec configuration d’un mot de passe et d’une base de données)

## 4. Dépendances et Versions Clés

### Backend
- Express : ^4.18.2
- dotenv : ^16.0.3
- mysql2 : ^3.2.0
- bcrypt : ^5.1.0
- TypeScript : ^5.0.4
- nodemon : ^2.0.22
- ts-node : ^10.9.1
- @types/express, @types/node, @types/bcrypt

### Frontend
- React & React-DOM : ^18.2.0
- Vite : ^4.3.9
- Tailwind CSS : ^3.2.7
- Chart.js : ^4.2.1
- react-chartjs-2 : ^5.2.0
- @vitejs/plugin-react : ^4.3.4
- TypeScript : ^5.0.4
- PostCSS & Autoprefixer


## 5. Remarques Complémentaires

### Backend
- Simulation d’un environnement de trading fictif.
- Connexion à MySQL gérée via un pool de connexions.
- Containerisation via Docker et Docker Compose.

### Frontend
- Interface en React 18 avec Vite.
- Tailwind CSS pour un design moderne.
- Chart.js pour les graphiques interactifs.

Ce cahier des charges pose les bases du projet **Demo Binance MVP** avec une approche modulaire et containerisée, facilitant le développement et l’évolution future.

