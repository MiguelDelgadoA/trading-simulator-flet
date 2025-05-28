# trading-simulator-flet
simulador_trading/
│
├── main.py                     # Entry point (Flet app)
├── requirements.txt            # Dependencies
├── README.md                   # Project description
├── LICENSE                     # MIT License (for example)
│
├── config/
│   └── settings.py             # General settings (coins, interval, etc.)
│
├── database/
│   ├── schema.sql              # SQL script to create tables
│   ├── init_db.py              # SQLite initialization (create DB and tables)
│   └── queries.py              # Specific SQL functions (insert order, check balance, etc.)
│
├── ws/
│   └── binance_ws.py           # Binance WebSocket listener, parses prices
│
├── core/
│   ├── trading.py              # Order execution logic (buy, sell, balance)
│   └── models.py               # Base classes (User, Order, etc.) – optional if using OOP
│
├── ui/
│   ├── __init__.py
│   ├── layout.py               # Flet app layout (main page, navigation)
│   └── components.py           # Reusable elements (buttons, forms, tables)
│
└── utils/
    └── helpers.py              # Helper functions (conversion, formatting, logs, etc.)



┌────────────┐
│   users    │
├────────────┤
│ id (PK)    │
│ username   │
│ email      │
│ password   │
│ created_at │
└────┬───────┘
     │
     │
     │  ┌────────────────────────────────────────────┐
     ▼  ▼                                            │
┌────────────┐              ┌────────────────────┐   │
│  wallets   │              │      orders        │   │
├────────────┤              ├────────────────────┤   │
│ id (PK)    │              │ id (PK)            │   │
│ user_id ─────────────────►│ user_id (FK)       │   │
│ crypto_sym──────────────► │ symbol (FK)        │   │
│ balance    │              │ type               │   │
└────┬───────┘              │ quantity           │   │
     │                      │ price              │   │
     │                      │ status             │   │
     │                      │ created_at         │   │
     │                      └────┬───────────────┘   │
     │                           │                   │
     │                           ▼                   │
     │                ┌─────────────────────┐        │
     │                │   transactions      │        │
     │                ├─────────────────────┤        │
     │                │ id (PK)             │        │
     └───────────────►│ order_id (FK)       │        │
                      │ exec_price          │        │
┌────────────┐        │ exec_quantity       │        │
│  cryptos   │        │ fee                 │        │
├────────────┤        │ timestamp           │        │
│ symbol (PK)│        └─────────────────────┘        │
│ name       │                                       │
└────────────┘◄──────────────────────────────────────┘