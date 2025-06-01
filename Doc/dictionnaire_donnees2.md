
# Dictionnaire de données

## 1. User
| Attribut       | Type               | Description                              |
|----------------|--------------------|------------------------------------------|
| id             | INT AUTO_INCREMENT | Identifiant unique de l’utilisateur      |
| username       | VARCHAR(100)       | Nom d’utilisateur unique                 |
| email          | VARCHAR(255)       | Adresse e-mail                           |
| password_hash  | VARCHAR(255)       | Hash du mot de passe                     |
| created_at     | DATETIME           | Date de création du compte               |
| last_login     | DATETIME           | Date et heure de la dernière connexion   |

## 2. Wallet
| Attribut         | Type               | Description                                                       |
|------------------|--------------------|-------------------------------------------------------------------|
| id               | INT AUTO_INCREMENT | Identifiant unique du portefeuille                                |
| user_id          | INT                | Référence à l’utilisateur (clé étrangère)                         |
| created_at       | DATETIME           | Date de création du portefeuille                                  |
| initial_balance  | DECIMAL(15,2)      | Solde virtuel de départ (ex. 10 000 $)                            |
| total_value      | DECIMAL(15,2)      | Valeur totale actuelle (mise à jour après chaque transaction)     |

## 3. Trade
| Attribut         | Type                   | Description                                                   |
|------------------|------------------------|---------------------------------------------------------------|
| id               | INT AUTO_INCREMENT     | Identifiant unique                                            |
| wallet_id        | INT                    | Référence au portefeuille (clé étrangère)                     |
| crypto_symbol    | VARCHAR(10)            | Code de la cryptomonnaie (BTC, ETH, …)                        |
| type             | ENUM('achat','vente')  | Nature de l’opération (achat ou vente)                        |
| amount           | DECIMAL(18,8)          | Quantité de cryptomonnaie échangée                            |
| price            | DECIMAL(15,2)          | Prix unitaire simulé au moment de la transaction              |
| fee              | DECIMAL(15,2)          | Frais de transaction simulés                                  |
| timestamp        | DATETIME               | Date et heure de l’opération                                  |

## 4. Price
| Attribut         | Type               | Description                                          |
|------------------|--------------------|------------------------------------------------------|
| id               | INT AUTO_INCREMENT | Identifiant unique                                   |
| crypto_symbol    | VARCHAR(10)        | Code de la cryptomonnaie                             |
| value            | DECIMAL(15,2)      | Valeur enregistrée (historique ou simulée)           |
| recorded_at      | DATETIME           | Date et heure d’enregistrement du cours              |

## 5. Learn
| Attribut      | Type               | Description                                     |
|---------------|--------------------|-------------------------------------------------|
| id            | INT AUTO_INCREMENT | Identifiant unique du module                    |
| title         | VARCHAR(150)       | Intitulé du module pédagogique                  |
| content       | TEXT               | Contenu pédagogique (texte, HTML ou Markdown)   |
| order_index   | INT                | Position du module dans la séquence             |

## 6. Préférence
| Attribut   | Type               | Description                                            |
|------------|--------------------|--------------------------------------------------------|
| id         | INT AUTO_INCREMENT | Identifiant unique                                     |
| user_id    | INT                | Référence à l’utilisateur (clé étrangère)              |
| key        | VARCHAR(100)       | Nom de la préférence (ex. 'theme', 'notifications')    |
| value      | VARCHAR(255)       | Valeur associée (ex. 'dark', 'true')                   |

## 7. Utilisateur_Module
| Attribut      | Type       | Description                                            |
|---------------|------------|--------------------------------------------------------|
| user_id       | INT        | Référence à l’utilisateur (clé étrangère)              |
| module_id     | INT        | Référence au module pédagogique (clé étrangère)        |
| is_completed  | BOOLEAN    | Indicateur si le module est complété par l’utilisateur |
| completed_at  | DATETIME   | Date et heure de complétion (facultatif)               |
