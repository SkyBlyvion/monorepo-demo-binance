-- 1. Table User
CREATE TABLE
    `User` (
        `user_id` INT NOT NULL AUTO_INCREMENT,
        `username` VARCHAR(100) NOT NULL,
        `email` VARCHAR(255) NOT NULL UNIQUE,
        `password_hash` VARCHAR(255) NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `last_login` DATETIME NULL,
        PRIMARY KEY (`user_id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 2. Table Wallet
CREATE TABLE
    `Wallet` (
        `wallet_id` INT NOT NULL AUTO_INCREMENT,
        `user_id` INT NOT NULL, -- FK vers User(user_id)
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `initial_balance` DECIMAL(15, 2) NOT NULL DEFAULT 10000.00,
        PRIMARY KEY (`wallet_id`),
        INDEX `idx_wallet_user` (`user_id`),
        CONSTRAINT `fk_wallet_user` FOREIGN KEY (`user_id`) 
        REFERENCES `User` (`user_id`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 3. Table Wallet_Holding
CREATE TABLE
    `Wallet_Holding` (
        `holding_id` INT NOT NULL AUTO_INCREMENT,
        `wallet_id` INT NOT NULL, -- FK vers Wallet(wallet_id)
        `crypto_symbol` VARCHAR(10) NOT NULL,
        `quantity` DECIMAL(18, 8) NOT NULL DEFAULT 0.00000000,
        `average_price` DECIMAL(15, 2) NULL,
        PRIMARY KEY (`holding_id`),
        INDEX `idx_wh_wallet` (`wallet_id`),
        INDEX `idx_wh_symbol` (`crypto_symbol`),
        CONSTRAINT `fk_wh_wallet` FOREIGN KEY (`wallet_id`) 
        REFERENCES `Wallet` (`wallet_id`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 4. Table Trade
CREATE TABLE
    `Trade` (
        `trade_id` INT NOT NULL AUTO_INCREMENT,
        `holding_id` INT NOT NULL, -- FK vers Wallet_Holding(holding_id)
        `crypto_symbol` VARCHAR(10) NOT NULL,
        `type` ENUM ('buy', 'sell') NOT NULL,
        `amount` DECIMAL(18, 8) NOT NULL,
        `price` DECIMAL(15, 2) NOT NULL,
        `fee` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
        `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (`trade_id`),
        INDEX `idx_trade_holding` (`holding_id`),
        CONSTRAINT `fk_trade_holding` FOREIGN KEY (`holding_id`) 
        REFERENCES `Wallet_Holding` (`holding_id`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 5. Table Price (autonome)
CREATE TABLE
    `Price` (
        `price_id` INT NOT NULL AUTO_INCREMENT,
        `crypto_symbol` VARCHAR(10) NOT NULL,
        `value` DECIMAL(15, 2) NOT NULL,
        `recorded_at` DATETIME NOT NULL,
        PRIMARY KEY (`price_id`),
        INDEX `idx_price_symbol_time` (`crypto_symbol`, `recorded_at`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 6. Table Learn
CREATE TABLE
    `Learn` (
        `learn_id` INT NOT NULL AUTO_INCREMENT,
        `title` VARCHAR(150) NOT NULL,
        `content` TEXT NOT NULL,
        `order_index` INT NOT NULL,
        PRIMARY KEY (`learn_id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 7. Table Preference
CREATE TABLE
    `Preference` (
        `preference_id` INT NOT NULL AUTO_INCREMENT,
        `user_id` INT NOT NULL, -- FK vers User(user_id)
        `pref_key` VARCHAR(100) NOT NULL,
        `pref_value` VARCHAR(255) NOT NULL,
        PRIMARY KEY (`preference_id`),
        INDEX `idx_pref_user` (`user_id`),
        CONSTRAINT `fk_preference_user` FOREIGN KEY (`user_id`) 
        REFERENCES `User` (`user_id`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- 8. Table User_Learn (jonction User ↔ Learn)
CREATE TABLE
    `User_Learn` (
        `user_id` INT NOT NULL, -- FK vers User(user_id)
        `learn_id` INT NOT NULL, -- FK vers Learn(learn_id)
        `is_completed` BOOLEAN NOT NULL DEFAULT FALSE,
        `completed_at` DATETIME NULL,
        PRIMARY KEY (`user_id`, `learn_id`),
        INDEX `idx_ul_user` (`user_id`),
        INDEX `idx_ul_learn` (`learn_id`),
        CONSTRAINT `fk_ul_user` FOREIGN KEY (`user_id`)
        REFERENCES `User` (`user_id`) ON DELETE CASCADE,
        CONSTRAINT `fk_ul_learn` FOREIGN KEY (`learn_id`) 
        REFERENCES `Learn` (`learn_id`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;



    