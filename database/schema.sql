-- Tabla usuarios
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla criptomonedas
CREATE TABLE IF NOT EXISTS cryptos (
    symbol TEXT PRIMARY KEY,
    name TEXT NOT NULL
);

-- Tabla wallets (balances)
CREATE TABLE IF NOT EXISTS wallets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    crypto_symbol TEXT NOT NULL,
    balance REAL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (crypto_symbol) REFERENCES cryptos(symbol),
    UNIQUE(user_id, crypto_symbol)
);

-- Tabla órdenes
CREATE TABLE IF NOT EXISTS orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    symbol TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('BUY', 'SELL')),
    quantity REAL NOT NULL,
    price REAL NOT NULL,
    status TEXT NOT NULL CHECK(status IN ('OPEN', 'EXECUTED', 'CANCELLED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (symbol) REFERENCES cryptos(symbol)
);

-- Tabla transacciones (ejecuciones)
CREATE TABLE IF NOT EXISTS transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    exec_price REAL NOT NULL,
    exec_quantity REAL NOT NULL,
    fee REAL DEFAULT 0,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO cryptos (symbol, name) VALUES
('aave', 'Aave'),
('ada', 'Cardano'),
('algo', 'Algorand'),
('ape', 'ApeCoin'),
('atom', 'Cosmos'),
('axs', 'Axie Infinity'),
('bat', 'Basic Attention Token'),
('bch', 'Bitcoin Cash'),
('bnb', 'Binance Coin'),
('btc', 'Bitcoin'),
('btt', 'BitTorrent'),
('celo', 'Celo'),
('chz', 'Chiliz'),
('comp', 'Compound'),
('crv', 'Curve DAO Token'),
('dash', 'Dash'),
('doge', 'Dogecoin'),
('dot', 'Polkadot'),
('eos', 'EOS'),
('eth', 'Ethereum'),
('fil', 'Filecoin'),
('flow', 'Flow'),
('ftm', 'Fantom'),
('gala', 'Gala Games'),
('hbar', 'Hedera Hashgraph'),
('iota', 'IOTA'),
('link', 'Chainlink'),
('ltc', 'Litecoin'),
('mana', 'Decentraland'),
('matic', 'Polygon'),
('near', 'NEAR Protocol'),
('neo', 'NEO'),
('okb', 'OKB'),
('pepe', 'Pepe Coin'),
('sand', 'The Sandbox'),
('shib', 'Shiba Inu'),
('slp', 'Smooth Love Potion'),
('snx', 'Synthetix'),
('sol', 'Solana'),
('sushi', 'SushiSwap'),
('trx', 'TRON'),
('uni', 'Uniswap'),
('usdc', 'USD Coin'),
('usdt', 'Tether'),
('vet', 'VeChain'),
('waves', 'Waves'),
('xlm', 'Stellar'),
('xrp', 'Ripple'),
('xtz', 'Tezos'),
('yfi', 'Yearn Finance'),
('zil', 'Zilliqa');
