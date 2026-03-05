-- Finance Sample Data

-- Accounts
INSERT INTO accounts (account_number, account_type, customer_name, balance, opened_date, status) VALUES
('1001', 'checking', 'John Smith', 15420.50, '2020-03-15', 'active'),
('1002', 'savings', 'John Smith', 52000.00, '2020-03-15', 'active'),
('1003', 'checking', 'Sarah Johnson', 8750.25, '2021-06-20', 'active'),
('1004', 'investment', 'Sarah Johnson', 125000.00, '2021-08-10', 'active'),
('1005', 'checking', 'Mike Williams', 3200.00, '2022-01-05', 'active'),
('1006', 'savings', 'Mike Williams', 18500.00, '2022-01-05', 'active'),
('1007', 'checking', 'Emily Brown', 12800.75, '2021-11-15', 'active'),
('1008', 'credit', 'Emily Brown', -2450.00, '2021-11-15', 'active'),
('1009', 'checking', 'David Jones', 950.00, '2023-02-28', 'active'),
('1010', 'investment', 'Lisa Garcia', 250000.00, '2020-09-10', 'active'),
('1011', 'savings', 'James Miller', 75000.00, '2022-04-15', 'active'),
('1012', 'checking', 'Emma Davis', 22100.00, '2021-07-22', 'active'),
('1013', 'checking', 'Closed Account', 0.00, '2019-01-01', 'closed'),
('1014', 'investment', 'Robert Martinez', 180000.00, '2020-11-30', 'active'),
('1015', 'savings', 'Jennifer Anderson', 45000.00, '2022-08-18', 'active');

-- Transactions
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description, category, merchant, is_recurring) VALUES
(1, 'deposit', 5000.00, '2024-01-01 09:00:00', 'Salary deposit', 'Income', 'Employer Inc', true),
(1, 'withdrawal', 150.00, '2024-01-03 14:30:00', 'ATM withdrawal', 'Cash', 'ATM', false),
(1, 'payment', 85.00, '2024-01-05 10:15:00', 'Electric bill', 'Utilities', 'Power Co', true),
(1, 'payment', 120.00, '2024-01-07 16:45:00', 'Grocery shopping', 'Groceries', 'Whole Foods', false),
(1, 'payment', 45.00, '2024-01-10 12:00:00', 'Restaurant', 'Dining', 'Local Bistro', false),
(1, 'deposit', 5000.00, '2024-02-01 09:00:00', 'Salary deposit', 'Income', 'Employer Inc', true),
(1, 'payment', 1200.00, '2024-02-03 10:00:00', 'Rent payment', 'Housing', 'Property Mgmt', true),
(1, 'payment', 89.99, '2024-02-05 14:20:00', 'Phone bill', 'Utilities', 'Telecom Co', true),
(2, 'deposit', 1000.00, '2024-01-15 11:00:00', 'Transfer from checking', 'Transfer', 'Internal', false),
(2, 'deposit', 500.00, '2024-02-15 11:00:00', 'Transfer from checking', 'Transfer', 'Internal', true),
(3, 'deposit', 4200.00, '2024-01-01 09:00:00', 'Salary deposit', 'Income', 'Tech Corp', true),
(3, 'payment', 65.00, '2024-01-08 18:30:00', 'Streaming services', 'Entertainment', 'Netflix', true),
(3, 'payment', 250.00, '2024-01-12 09:45:00', 'Online shopping', 'Shopping', 'Amazon', false),
(5, 'deposit', 2800.00, '2024-01-01 09:00:00', 'Salary deposit', 'Income', 'Small Biz', true),
(5, 'withdrawal', 500.00, '2024-01-05 15:00:00', 'ATM withdrawal', 'Cash', 'ATM', false),
(5, 'payment', 800.00, '2024-01-10 10:00:00', 'Rent payment', 'Housing', 'Landlord', true),
(7, 'deposit', 6500.00, '2024-01-01 09:00:00', 'Salary deposit', 'Income', 'Corp America', true),
(7, 'payment', 450.00, '2024-01-15 14:00:00', 'Insurance', 'Insurance', 'InsureCo', true),
(8, 'payment', 350.00, '2024-01-20 16:30:00', 'Credit card purchase', 'Shopping', 'Dept Store', false),
(8, 'payment', 150.00, '2024-01-25 12:15:00', 'Gas station', 'Transportation', 'Gas Station', false);

-- Transfers
INSERT INTO transfers (from_account_id, to_account_id, amount, transfer_date, status) VALUES
(1, 2, 1000.00, '2024-01-15 11:00:00', 'completed'),
(1, 2, 500.00, '2024-02-15 11:00:00', 'completed'),
(3, 4, 2000.00, '2024-01-20 10:30:00', 'completed'),
(5, 6, 800.00, '2024-01-25 14:00:00', 'completed'),
(7, 8, 500.00, '2024-02-01 09:00:00', 'completed'),
(12, 11, 1500.00, '2024-02-05 11:30:00', 'completed');

-- Stocks
INSERT INTO stocks (symbol, company_name, sector, current_price) VALUES
('AAPL', 'Apple Inc.', 'Technology', 185.50),
('GOOGL', 'Alphabet Inc.', 'Technology', 142.30),
('MSFT', 'Microsoft Corp.', 'Technology', 415.80),
('AMZN', 'Amazon.com Inc.', 'Consumer', 178.25),
('TSLA', 'Tesla Inc.', 'Automotive', 195.40),
('JPM', 'JPMorgan Chase', 'Financial', 195.20),
('V', 'Visa Inc.', 'Financial', 285.60),
('JNJ', 'Johnson & Johnson', 'Healthcare', 156.80),
('WMT', 'Walmart Inc.', 'Consumer', 165.30),
('PG', 'Procter & Gamble', 'Consumer', 158.90);

-- Portfolio
INSERT INTO portfolio (account_id, stock_id, shares, avg_purchase_price, purchase_date) VALUES
(4, 1, 50.0000, 150.00, '2021-08-15'),
(4, 3, 30.0000, 320.00, '2021-09-20'),
(4, 6, 100.0000, 140.00, '2022-01-10'),
(10, 1, 200.0000, 140.00, '2020-09-15'),
(10, 2, 150.0000, 100.00, '2020-10-20'),
(10, 3, 100.0000, 280.00, '2020-11-15'),
(10, 4, 80.0000, 130.00, '2021-01-10'),
(10, 5, 50.0000, 250.00, '2021-03-15'),
(14, 6, 150.0000, 150.00, '2020-12-01'),
(14, 7, 100.0000, 220.00, '2021-02-15'),
(14, 8, 75.0000, 165.00, '2021-04-20'),
(14, 9, 60.0000, 145.00, '2021-06-10');

-- Stock Prices (last 10 days for each stock)
INSERT INTO stock_prices (stock_id, price_date, open_price, close_price, high_price, low_price, volume) VALUES
(1, '2024-02-01', 183.00, 185.50, 186.20, 182.50, 58000000),
(1, '2024-02-02', 185.50, 184.80, 186.00, 184.00, 52000000),
(1, '2024-02-05', 184.80, 186.20, 187.00, 184.50, 61000000),
(1, '2024-02-06', 186.20, 185.90, 187.50, 185.00, 55000000),
(1, '2024-02-07', 185.90, 187.30, 188.00, 185.50, 63000000),
(2, '2024-02-01', 140.00, 142.30, 143.00, 139.50, 28000000),
(2, '2024-02-02', 142.30, 141.80, 143.50, 141.00, 25000000),
(2, '2024-02-05', 141.80, 143.50, 144.20, 141.50, 30000000),
(2, '2024-02-06', 143.50, 142.90, 144.00, 142.00, 27000000),
(2, '2024-02-07', 142.90, 144.20, 145.00, 142.50, 32000000),
(3, '2024-02-01', 410.00, 415.80, 417.00, 409.00, 22000000),
(3, '2024-02-02', 415.80, 414.50, 418.00, 413.00, 20000000),
(3, '2024-02-05', 414.50, 418.20, 420.00, 414.00, 25000000),
(3, '2024-02-06', 418.20, 416.80, 419.50, 415.00, 21000000),
(3, '2024-02-07', 416.80, 420.50, 422.00, 416.00, 28000000);
