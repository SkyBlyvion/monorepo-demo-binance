# Cahier des Charges – BlockLumen (Projet Complet)

## 1. Contexte et Objectifs

### Contexte
BlockLumen se positionne comme une plateforme de simulation et d’apprentissage dédiée aux débutants souhaitant maîtriser le trading de cryptomonnaies sans risque financier réel. Contrairement au MVP initial, le projet complet inclut l’ensemble des fonctionnalités nécessaires pour déployer une solution robuste et évolutive en production, intégrant la gestion de plusieurs portefeuilles, un suivi détaillé des positions, des modules pédagogiques approfondis, et une interface utilisateur optimisée.

### Objectifs
- **Offrir une expérience utilisateur complète** : authentification sécurisée, multi-portefeuille, gestion de détentions (holdings) par cryptomonnaie, et historique détaillé des transactions.
- **Assurer un calcul de valeur de portefeuille précis** : chaque crypto est représentée dans `Wallet_Holding`, avec quantité et prix moyen d’acquisition, pour un calcul dynamique via l’historique des cours.
- **Proposer des modules pédagogiques** : permettre à l’utilisateur de suivre des séquences de formation (texte, vidéo, quiz) et de suivre sa progression (`User_Learn`).
- **Être pleinement responsive** : interface claire et réactive sur desktop, tablette et mobile.
- **Garantir la maintenabilité et la scalabilité** : architecture modulaire (frontend React + backend Node.js/Express + MySQL), containerisation via Docker et orchestration avec Docker Compose.

---

## 2. Fonctionnalités

### 2.1. Authentification & Gestion du Profil
- **Créer un compte**  
  - Formulaire d’inscription : `username`, `email`, `password`.  
  - Hachage des mots de passe avec bcrypt.  
  - Verrouillage des comptes en cas de tentatives d’accès frauduleuses (optionnel V2).
- **Se connecter / Se déconnecter**  
  - Authentification via JWT.  
  - Middleware pour protéger les routes sensibles.
- **Modifier profil et préférences**  
  - Page « Compte » permettant à l’utilisateur de mettre à jour son mot de passe, email, et préférences (thème `light/dark`, notifications).

### 2.2. Gestion des Portefeuilles et Holdings
- **Créer un portefeuille**  
  - Initialiser un nouveau portefeuille virtuel avec solde de départ.  
  - Un utilisateur peut posséder plusieurs portefeuilles (`1:N`).
- **Lister mes portefeuilles**  
  - Affichage de la liste de tous les portefeuilles de l’utilisateur, avec date de création et solde initial.
- **Voir détail d’un portefeuille**  
  - Pour chaque portefeuille, afficher :  
    - Toutes les lignes de détention (`Wallet_Holding`) : cryptomonnaie, quantité, prix moyen.  
    - Calcul dynamique de la valeur totale du portefeuille.  
    - Graphique des variations de valeur (agrégation via `Price`).
- **Ajouter / Mettre à jour un holding** (inclut lors d’un Trade)  
  - Lorsqu’on achète une crypto : si la ligne `Wallet_Holding` existe, mettre à jour `quantity` et recalculer `average_price` ; sinon, créer une nouvelle ligne.  
  - Lorsqu’on vend : décrémenter `quantity` et supprimer la ligne si `quantity = 0`.

### 2.3. Simulation de Trading (Trade)
- **Créer une transaction** (`Trade`)  
  - Enregistrer chaque opération d’`achat` ou de `vente` : `holding_id`, `crypto_symbol`, `type`, `amount`, `price`, `fee`, `timestamp`.  
  - Déclencher la mise à jour de `Wallet_Holding` correspondante.
- **Consulter historique des transactions**  
  - Filtrer par portefeuille ou cryptomonnaie, avec pagination et tri par date.
- **Calculer les frais et vérification de solde**  
  - Vérifier que l’utilisateur dispose de suffisamment de fonds fictifs avant un achat.  
  - Calculer automatiquement les frais simulés (pourcentages ou montant fixe).

### 2.4. Suivi des Cours (Price)
- **Insertion de l’historique des cours**  
  - Récupérer périodiquement via une API tierce (CoinGecko) et insérer dans `Price` : `crypto_symbol`, `value`, `recorded_at`.
- **Graphiques en temps réel**  
  - Faire des requêtes sur `Price` pour afficher les variations de cours (derniers N points) dans `Chart.js`.

### 2.5. Modules Pédagogiques (Learn)
- **Lister les modules disponibles**  
  - Afficher `Learn`: titre, contenu, ordre.
- **Consulter un module**  
  - Visionner le contenu pédagogique (texte, images, vidéos intégrées).
- **Marquer comme complété**  
  - Créer / mettre à jour une entrée dans `User_Learn`: `is_completed = TRUE`, `completed_at = NOW()`.

---

## 3. Technologies et Outils

### 3.1. Backend
- **Langage & Framework** : Node.js (v18+) avec Express.js et TypeScript.  
- **Base de données** : MySQL 8.0 (InnoDB, utf8mb4). DDL via `BlockLumenBDD.sql`.  
- **ORM / Query Builder** : TypeORM ou Sequelize (optionnel, pour faciliter les migrations).  
- **Authentification** : JWT + bcrypt.  
- **Containerisation** : Docker (Dockerfile) et Docker Compose.  
- **Tests** : Jest ou Mocha/Chai pour tests unitaires et d’intégration.

### 3.2. Frontend
- **Bibliothèque** : React 18 avec TypeScript.  
- **Build** : Vite (v4) pour rapidité.  
- **CSS** : Tailwind CSS (v3) pour un design moderne et responsive.  
- **Graphiques** : Chart.js (v4) via React-Chartjs-2.  
- **Gestion d’état** : Context API ou Redux (simple).  
- **Tests** : React Testing Library + Jest.

### 3.3. Outils de Développement
- **Versioning** : Git + GitHub.  
- **IDE** : VS Code avec extensions TypeScript, ESLint, Prettier.  
- **API Testing** : Postman ou Insomnia.  
- **Maquettage** : Figma pour wireframes et maquettes haute-fidélité.  
- **Diagrammes** : Mermaid (intégré dans Markdown) ou Draw.io pour MCD, UML, etc.  
- **CI/CD** (évolutif) : GitHub Actions pour tests et déploiement automatiques.

---

## 4. Architecture du Projet

```
monorepo-blocklumen/
├── client/         # Frontend (React, Vite, Tailwind, Chart.js)
│   ├── public/
│   ├── src/
│   ├── package.json
│   └── vite.config.ts
├── server/         # Backend (Express, TypeScript, MySQL)
│   ├── src/
│   │   ├── controllers/
│   │   ├── entities/       # TypeORM entities ou modèles
│   │   ├── routes/
│   │   ├── services/
│   │   └── index.ts
│   ├── .env
│   ├── package.json
│   ├── tsconfig.json
│   └── Dockerfile
├── docker-compose.yml
└── README.md
```

- **client/** :  
  - Contient React, Tailwind CSS, composants de chart.  
  - Pages principales : Login, Dashboards, PortfolioDetail, TradesHistory, Learn, Preferences.

- **server/** :  
  - Routes Express :  
    - `/auth` (signup, login, logout).  
    - `/users` (profil, préférences).  
    - `/wallets` (CRUD portefeuilles).  
    - `/holdings` (CRUD détentions).  
    - `/trades` (CRUD transactions, calcul updates).  
    - `/prices` (insertion, lecture historique).  
    - `/learn` (liste modules).  
    - `/user-learn` (CRUD progression modules).  
  - Logic métier dans services, accès DB via TypeORM/Sequelize ou mysql2.

- **docker-compose.yml** :  
  - Service **db** (MySQL).  
  - Service **backend**.  
  - Service **frontend** (optionnel pour preview production).

---

## 5. Contraintes et Bonnes Pratiques

- **Sécurité** :  
  - Hachage + salage des mots de passe avec bcrypt.  
  - Utilisation de HTTPS en production.  
  - Validation des entrées utilisateur (e.g. Joi ou express-validator).

- **Performance** :  
  - Pagination sur les endpoints `/trades` et `/wallets/:id/holdings`.  
  - Mise en cache possible des requêtes de prix via Redis ou similar (V2).

- **Scalabilité** :  
  - Architecture modulaire : séparation claire des couches (controllers, services, data).  
  - Possibilité de migrer l’historique des prix vers un système spécialisé (TimescaleDB ou InfluxDB) si très volumineux.

- **Qualité de Code** :  
  - ESLint + Prettier pour formater automatiquement.  
  - Tests unitaires pour les fonctions critiques (calculs de prix, updates de holdings).  
  - Code reviews systématiques via Pull Requests.

- **Accessibilité et UX** :  
  - Contraste suffisant des couleurs (Tailwind configuration).  
  - Composants accessibles (ARIA).  
  - Navigation clavier possible.

---

## 6. Plan de Développement

1. **Initialisation du Monorepo**  
   - Créer les dossiers `client` et `server`.  
   - Initialiser Git, ajouter README de présentation.

2. **Setup Backend**  
   - Configurer TypeScript, Express, connection MySQL.  
   - Créer entités TypeORM ou modèles Sequelize pour User, Wallet, Wallet_Holding, Trade, Price, Learn, Preference, User_Learn.  
   - Implémenter routes d’authentification (signup, login).  
   - Implémenter CRUD pour `Wallet`, `Wallet_Holding`, `Trade`.

3. **Setup Frontend**  
   - Initialiser Vite + React + Tailwind.  
   - Créer pages de connexion, inscription.  
   - Créer layout principal (navbar, footer).

4. **Intégration Wallet & Holdings**  
   - Front : Formulaire création portefeuille.  
   - Back : Endpoint POST `/wallets`, GET `/wallets`.  
   - Front : Page “Mes portefeuilles” avec carte pour chaque portefeuille.

5. **Gestion des Trades**  
   - Back : Endpoint POST `/trades` (logique insertion + update `Wallet_Holding`).  
   - Front : UI “Trade” (sélection portefeuille, crypto, buy/sell).  
   - Back : Endpoint GET `/trades` avec filtres.

6. **Affichage des Cours et Valeur de Portefeuille**  
   - Back : Cronjob ou route pour récupérer cours via CoinGecko et insérer dans `Price`.  
   - Front : Graphique Chart.js sur la page détail portefeuille (fetch `/prices?symbol=BTC&limit=...`).  
   - Calcul dynamique de la valeur via une UI fetch `/wallets/:id/value`.

7. **Modules Pédagogiques**  
   - Back : Endpoints GET `/learn`, POST/PUT `/user-learn`.  
   - Front : Page “Learn” listant les modules, détails, bouton “Marquer comme Complété”.

8. **Préférences & Profil**  
   - Back : Endpoints GET/PUT `/users/:id`, GET/POST `/preferences`.  
   - Front : Page “Profil” avec formulaire modification email/password et préférences (toggle thème).

9. **Tests & Qualité**  
   - Écrire tests unitaires pour services critiques (wallet calcul, average_price).  
   - Tests d’intégration pour API (auth, wallet, trade).

10. **Déploiement & CI/CD**  
   - Configurer GitHub Actions pour exécuter lint, tests, build Docker.  
   - Déployer sur un cluster (Heroku, AWS, DigitalOcean, etc.).

---

## 7. Livrables

- **Plateforme Complète** :  
  - Système d’authentification (inscription, connexion).  
  - Gestion des portefeuilles et holdings par crypto.  
  - Simulation de trading (buy/sell) avec mise à jour automatique des ports.  
  - Affichage des cours en temps réel et graphique de valeur.  
  - Modules pédagogiques et suivi de progression.  
  - Page profil et préférences utilisateur.  
- **Base de Données** :  
  - Script DDL complet (`BlockLumenBDD.sql`).  
  - Schéma Merise (MCD, MLD).  
- **Documentation Technique** :  
  - Cahier des Charges (.md).  
  - Dictionnaire de Données (.md).  
  - Guide d’installation et d’exécution (README).  
  - Mémoire de 30 pages décrivant la conception, le développement, les choix techniques et retours d’expérience.  
- **Maquettes et Wireframes** :  
  - Fichier Figma ou exports PNG montrant les écrans principaux.  
- **Slide Deck (optionnel)** :  
  - Présentation succincte du projet (Objectifs, Architecture, Démonstration, Axes d’amélioration).

---

## 8. Planning Prévisionnel

| Étape                       | Durée estimée  | Responsable       |
| --------------------------- | -------------- | ----------------- |
| Conception et modélisation  | 1 semaine      | Nicolas Lopez     |
| Setup initial frontend / backend | 1 semaine  | Nicolas Lopez     |
| Authentification & Profil   | 1 semaine      | Nicolas Lopez     |
| Portefeuille & Holdings      | 2 semaines     | Nicolas Lopez     |
| Simulation de Trading       | 2 semaines     | Nicolas Lopez     |
| Affichage des Cours & Dashboard | 1 semaine  | Nicolas Lopez     |
| Modules Pédagogiques        | 1 semaine      | Nicolas Lopez     |
| Tests & Qualité             | 1 semaine      | Nicolas Lopez     |
| Préparation du mémoire      | 2 semaines     | Nicolas Lopez     |
| Finalisation & Présentation | 1 semaine      | Nicolas Lopez     |

---

## 9. Annexes

- **Annexe A** : Schéma Merise (MCD, MLD)  
- **Annexe B** : Dictionnaire de Données  
- **Annexe C** : Scripts SQL  
- **Annexe D** : Wireframes / Maquettes Figma  
- **Annexe E** : Guide d’installation rapide  

---

> **Note :** Ce document est évolutif et pourra être mis à jour en fonction des besoins futurs (version mobile native, support multi-devises, modules avancés d’analyse technique, etc.).