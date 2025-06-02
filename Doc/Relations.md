# Relations
User → Wallet : One-to-One
•	Un utilisateur peut posséder plusieurs portefeuilles, et chaque portefeuille appartient à un seul utilisateur.
•	Implémentation : dans la table Wallet, user_id est NOT NULL et référencé par une FK → User(user_id).

Wallet → Wallet_Holding : One-to-Many
•	Un portefeuille peut enregistrer plusieurs lignes de détention, chaque ligne de détention appartenant à un unique portefeuille.
•	Implémentation : dans la table Wallet_Holding, wallet_id est NOT NULL et référencé par une FK → Wallet(wallet_id).

Wallet_Holding → Trade : One-to-Many
•	Une ligne de détention (pour une cryptomonnaie précise) peut enregistrer plusieurs transactions, chaque transaction appartenant à une seule détention.
•	Implémentation : dans la table Trade, holding_id est NOT NULL et référencé par une FK → Wallet_Holding(holding_id).

User → Preference : One-to-Many
•	Un utilisateur peut avoir plusieurs préférences, chaque préférence rattachée à un seul utilisateur.
•	Implémentation : dans la table Preference, user_id est NOT NULL et référencé par une FK → User(user_id).

User ↔ Learn (Module Pédagogique) : Many-to-Many
•	Un utilisateur peut suivre plusieurs modules, et un module peut être suivi par plusieurs utilisateurs.
•	Implémentation : table User_Learn avec (user_id, learn_id) en PK composite, chacune référencée par une FK → User(user_id) et Learn(learn_id). Les champs is_completed et completed_at enregistrent la progression.
Price : Entité autonome
•	Stocke l’historique des cours sans relation directe en V1.
•	Implémentation : pas de FK ; un index (crypto_symbol, recorded_at) optimise les recherches temporelles.

Résumé des cardinalités (notation Merise) :
•	Utilisateur (0..1) – (1..1) Wallet
•	Wallet (1..1) – (0..n) Wallet_Holding
•	Wallet_Holding (1..1) – (0..n) Trade
•	Utilisateur (1..1) – (0..n) Preference
•	Utilisateur (0..n) – (0..n) Module_Pedagogique (via User_Learn)
•	Price : entité autonome sans relation directe en V1.
Cette section met en évidence, pour chaque association, le sens et le fonctionnement concret des relations dans le schéma physique de BlockLumen.
