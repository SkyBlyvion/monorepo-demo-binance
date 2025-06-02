ENTITY / PK / ATTRIBUTS / FK
User ( #user_id, username, email, password_hash, created_at, last_login )
Wallet ( #wallet_id, created_at, initial_balance, #user_id )
Wallet_Holding ( #holding_id, crypto_symbol, quantity, average_price, #wallet_id )
Trade ( #trade_id, crypto_symbol, type, amount, price, fee, timestamp, #holding_id )
Preference ( #preference_id, key, value, #user_id )
Price ( #price_id, crypto_symbol, value, recorded_at )
Learn ( #learn_id, title, content, order_index )
User_Learn ( #user_id, #learn_id, is_completed, completed_at )