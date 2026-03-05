-- Finance Sandbox Database Schema
-- Run this in finance_sandbox database

-- Accounts
CREATE TABLE IF NOT EXISTS accounts (
    account_id SERIAL PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(15, 2) NOT NULL,
    opened_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

-- Transactions
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    transaction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP NOT NULL,
    description TEXT,
    category VARCHAR(100),
    merchant VARCHAR(200),
    is_recurring BOOLEAN DEFAULT FALSE
);

-- Transfers
CREATE TABLE IF NOT EXISTS transfers (
    transfer_id SERIAL PRIMARY KEY,
    from_account_id INT REFERENCES accounts(account_id),
    to_account_id INT REFERENCES accounts(account_id),
    amount DECIMAL(15, 2) NOT NULL,
    transfer_date TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- Stocks
CREATE TABLE IF NOT EXISTS stocks (
    stock_id SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    company_name VARCHAR(200) NOT NULL,
    sector VARCHAR(100),
    current_price DECIMAL(10, 2)
);

-- Portfolio
CREATE TABLE IF NOT EXISTS portfolio (
    portfolio_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    stock_id INT REFERENCES stocks(stock_id),
    shares DECIMAL(15, 4) NOT NULL,
    avg_purchase_price DECIMAL(10, 2) NOT NULL,
    purchase_date DATE NOT NULL
);

-- Stock Prices History
CREATE TABLE IF NOT EXISTS stock_prices (
    id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES stocks(stock_id),
    price_date DATE NOT NULL,
    open_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    volume BIGINT,
    UNIQUE(stock_id, price_date)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_transactions_account ON transactions(account_id);
CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(transaction_date);
CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(transaction_type);
CREATE INDEX IF NOT EXISTS idx_transfers_from ON transfers(from_account_id);
CREATE INDEX IF NOT EXISTS idx_transfers_to ON transfers(to_account_id);
CREATE INDEX IF NOT EXISTS idx_portfolio_account ON portfolio(account_id);
CREATE INDEX IF NOT EXISTS idx_stock_prices_stock ON stock_prices(stock_id);
CREATE INDEX IF NOT EXISTS idx_stock_prices_date ON stock_prices(price_date);
