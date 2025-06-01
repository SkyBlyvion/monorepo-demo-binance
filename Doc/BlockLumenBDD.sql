-- 1. Table User
CREATE TABLE `User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` DATETIME NULL,
  PRIMARY KEY (`user_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 2. Table Wallet
CREATE TABLE `Wallet` (
  `wallet_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL UNIQUE,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `initial_balance` DECIMAL(15,2) NOT NULL DEFAULT 10000.00,
  `total_value` DECIMAL(15,2) NOT NULL DEFAULT 10000.00,
  PRIMARY KEY (`wallet_id`),
  CONSTRAINT `fk_wallet_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 3. Table Trade
CREATE TABLE `Trade` (
  `Trade_id` INT NOT NULL AUTO_INCREMENT,
  `portefeuille_id` INT NOT NULL,
  `crypto_symbol` VARCHAR(10) NOT NULL,
  `type` ENUM('achat','vente') NOT NULL,
  `amount` DECIMAL(18,8) NOT NULL,
  `price` DECIMAL(15,2) NOT NULL,
  `fee` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Trade_id`),
  INDEX `idx_Trade_wallet` (`portefeuille_id`),
  CONSTRAINT `fk_Trade_wallet`
    FOREIGN KEY (`portefeuille_id`)
    REFERENCES `Wallet` (`wallet_id`)
    ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 4. Table Price
CREATE TABLE `Price` (
  `price_id` INT NOT NULL AUTO_INCREMENT,
  `crypto_symbol` VARCHAR(10) NOT NULL,
  `value` DECIMAL(15,2) NOT NULL,
  `recorded_at` DATETIME NOT NULL,
  PRIMARY KEY (`price_id`),
  INDEX `idx_price_symbol_time` (`crypto_symbol`, `recorded_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 5. Table Learn (Module_Pedagogique)
CREATE TABLE `Learn` (
  `learn_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `content` TEXT NOT NULL,
  `order_index` INT NOT NULL,
  PRIMARY KEY (`learn_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 6. Table Preference
CREATE TABLE `Preference` (
  `preference_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `key` VARCHAR(100) NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`preference_id`),
  INDEX `idx_pref_user` (`user_id`),
  CONSTRAINT `fk_preference_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 7. Table User_Learn (jonction Utilisateur / Learn)
CREATE TABLE `User_Learn` (
  `user_id` INT NOT NULL,
  `learn_id` INT NOT NULL,
  `is_completed` BOOLEAN NOT NULL DEFAULT FALSE,
  `completed_at` DATETIME NULL,
  PRIMARY KEY (`user_id`, `learn_id`),
  INDEX `idx_ul_user` (`user_id`),
  INDEX `idx_ul_learn` (`learn_id`),
  CONSTRAINT `fk_ul_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_ul_learn`
    FOREIGN KEY (`learn_id`)
    REFERENCES `Learn` (`learn_id`)
    ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


