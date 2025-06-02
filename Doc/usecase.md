```mermaid
graph TD;

%% Diagramme de cas d’utilisation BlockLumen
actor "Utilisateur\n(non authentifié)" as Guest
actor "Utilisateur\n(authentifié)"     as User

%% Cas d’utilisation non authentifiés
rectangle "Partie non authentifiée" {
  Guest --> (Créer un compte)
  Guest --> (Se connecter)
}

%% Cas d’utilisation authentifiés
rectangle "Partie authentifiée" {
  User --> (Gérer profil et préférences)
  User --> (Créer un portefeuille)
  User --> (Lister mes portefeuilles)
  User --> (Voir détail d’un portefeuille)
  User --> (Effectuer un trade)
  User --> (Consulter historique des transactions)
  User --> (Suivre modules pédagogiques)
  User --> (Se déconnecter)
}

%% Include / Extend
(Voir détail d’un portefeuille) ..> (Voir mes holdings)         : <<include>>
(Voir détail d’un portefeuille) ..> (Consulter cours actuel)      : <<include>>

(Effectuer un trade) ..> (Mettre à jour/inserer un holding)      : <<include>>
(Effectuer un trade) ..> (Vérifier solde disponible)             : <<include>>
(Effectuer un trade) ..> (Calculer frais)                       : <<include>>

(Suivre modules pédagogiques) ..> (Marquer comme complété)      : <<include>>
```