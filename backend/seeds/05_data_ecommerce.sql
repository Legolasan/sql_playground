-- E-commerce Sample Data

-- Customers
INSERT INTO customers (first_name, last_name, email, city, country, signup_date, is_premium) VALUES
('John', 'Smith', 'john.smith@email.com', 'New York', 'USA', '2023-01-15', true),
('Sarah', 'Johnson', 'sarah.j@email.com', 'Los Angeles', 'USA', '2023-02-20', false),
('Mike', 'Williams', 'mike.w@email.com', 'Chicago', 'USA', '2023-03-10', true),
('Emily', 'Brown', 'emily.b@email.com', 'Houston', 'USA', '2023-04-05', false),
('David', 'Jones', 'david.j@email.com', 'Phoenix', 'USA', '2023-05-12', false),
('Lisa', 'Garcia', 'lisa.g@email.com', 'London', 'UK', '2023-06-18', true),
('James', 'Miller', 'james.m@email.com', 'Toronto', 'Canada', '2023-07-22', false),
('Emma', 'Davis', 'emma.d@email.com', 'Sydney', 'Australia', '2023-08-30', true),
('Robert', 'Martinez', 'robert.m@email.com', 'Berlin', 'Germany', '2023-09-14', false),
('Jennifer', 'Anderson', 'jennifer.a@email.com', 'Paris', 'France', '2023-10-25', true),
('William', 'Taylor', 'william.t@email.com', 'Seattle', 'USA', '2023-11-08', false),
('Amanda', 'Thomas', 'amanda.t@email.com', 'Boston', 'USA', '2023-12-01', false),
('Chris', 'Jackson', 'chris.j@email.com', 'Miami', 'USA', '2024-01-10', true),
('Michelle', 'White', 'michelle.w@email.com', 'Denver', 'USA', '2024-01-20', false),
('Kevin', 'Harris', 'kevin.h@email.com', 'Atlanta', 'USA', '2024-02-05', false);

-- Products
INSERT INTO products (name, category, subcategory, price, cost, stock_quantity) VALUES
('iPhone 15 Pro', 'Electronics', 'Smartphones', 1199.99, 800.00, 150),
('Samsung Galaxy S24', 'Electronics', 'Smartphones', 999.99, 650.00, 200),
('MacBook Pro 14"', 'Electronics', 'Laptops', 1999.99, 1400.00, 75),
('Dell XPS 15', 'Electronics', 'Laptops', 1599.99, 1100.00, 100),
('Sony WH-1000XM5', 'Electronics', 'Headphones', 349.99, 200.00, 300),
('AirPods Pro 2', 'Electronics', 'Headphones', 249.99, 150.00, 400),
('Nike Air Max 90', 'Clothing', 'Shoes', 129.99, 60.00, 500),
('Adidas Ultraboost', 'Clothing', 'Shoes', 179.99, 80.00, 350),
('Levi 501 Jeans', 'Clothing', 'Pants', 79.99, 35.00, 600),
('North Face Jacket', 'Clothing', 'Outerwear', 299.99, 150.00, 200),
('Instant Pot Pro', 'Home', 'Kitchen', 149.99, 80.00, 250),
('Dyson V15 Vacuum', 'Home', 'Appliances', 749.99, 450.00, 100),
('Kindle Paperwhite', 'Electronics', 'E-readers', 139.99, 80.00, 400),
('PlayStation 5', 'Electronics', 'Gaming', 499.99, 380.00, 50),
('Nintendo Switch', 'Electronics', 'Gaming', 299.99, 200.00, 175);

-- Orders
INSERT INTO orders (customer_id, order_date, status, shipping_address, total_amount) VALUES
(1, '2024-01-05 10:30:00', 'delivered', '123 Main St, New York, NY', 1549.98),
(2, '2024-01-08 14:20:00', 'delivered', '456 Oak Ave, Los Angeles, CA', 349.99),
(3, '2024-01-10 09:15:00', 'delivered', '789 Pine Rd, Chicago, IL', 2249.98),
(1, '2024-01-15 16:45:00', 'shipped', '123 Main St, New York, NY', 249.99),
(4, '2024-01-18 11:30:00', 'delivered', '321 Elm St, Houston, TX', 129.99),
(5, '2024-01-20 13:00:00', 'delivered', '654 Maple Dr, Phoenix, AZ', 999.99),
(6, '2024-01-22 10:00:00', 'delivered', '10 Baker St, London, UK', 449.98),
(3, '2024-01-25 15:30:00', 'shipped', '789 Pine Rd, Chicago, IL', 749.99),
(7, '2024-01-28 12:15:00', 'delivered', '100 Queen St, Toronto, CA', 179.99),
(8, '2024-02-01 09:45:00', 'processing', '50 Harbour St, Sydney, AU', 1999.99),
(9, '2024-02-03 14:00:00', 'shipped', '20 Berlin Ave, Berlin, DE', 499.99),
(10, '2024-02-05 11:20:00', 'delivered', '5 Champs St, Paris, FR', 629.98),
(2, '2024-02-08 16:30:00', 'delivered', '456 Oak Ave, Los Angeles, CA', 1199.99),
(11, '2024-02-10 10:10:00', 'shipped', '200 Pike St, Seattle, WA', 299.99),
(12, '2024-02-12 13:45:00', 'processing', '88 Beacon St, Boston, MA', 149.99);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount) VALUES
(1, 1, 1, 1199.99, 0), (1, 5, 1, 349.99, 0),
(2, 5, 1, 349.99, 0),
(3, 3, 1, 1999.99, 0), (3, 6, 1, 249.99, 0),
(4, 6, 1, 249.99, 0),
(5, 7, 1, 129.99, 0),
(6, 2, 1, 999.99, 0),
(7, 5, 1, 349.99, 0), (7, 9, 1, 79.99, 0), (7, 7, 1, 129.99, 110.00),
(8, 12, 1, 749.99, 0),
(9, 8, 1, 179.99, 0),
(10, 3, 1, 1999.99, 0),
(11, 14, 1, 499.99, 0),
(12, 10, 1, 299.99, 0), (12, 5, 1, 349.99, 20.00),
(13, 1, 1, 1199.99, 0),
(14, 15, 1, 299.99, 0),
(15, 11, 1, 149.99, 0);

-- Reviews
INSERT INTO reviews (product_id, customer_id, rating, review_text, created_at) VALUES
(1, 1, 5, 'Amazing phone! Best I have ever owned.', '2024-01-20 10:00:00'),
(1, 2, 4, 'Great phone but expensive.', '2024-02-10 14:30:00'),
(3, 3, 5, 'Perfect for development work!', '2024-01-30 09:15:00'),
(5, 2, 5, 'Best headphones ever. Noise cancellation is incredible.', '2024-01-12 16:00:00'),
(7, 4, 4, 'Comfortable and stylish.', '2024-01-25 11:45:00'),
(2, 5, 4, 'Great Android phone.', '2024-01-28 13:20:00'),
(12, 3, 5, 'Worth every penny!', '2024-02-01 10:30:00'),
(14, 9, 5, 'Gaming is amazing on this!', '2024-02-08 15:00:00'),
(15, 11, 4, 'Fun console for the whole family.', '2024-02-15 12:00:00'),
(6, 1, 4, 'Good earbuds, great integration with iPhone.', '2024-01-22 14:15:00');
