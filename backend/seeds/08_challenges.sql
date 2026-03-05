-- SQL Playground Challenges

-- Categories
INSERT INTO categories (name, slug, difficulty, description, order_index) VALUES
('SELECT Basics', 'select-basics', 'beginner', 'Learn the fundamentals of retrieving data', 1),
('Filtering with WHERE', 'where-clause', 'beginner', 'Filter rows based on conditions', 2),
('Sorting and Limiting', 'order-limit', 'beginner', 'Sort and paginate your results', 3),
('Aggregate Functions', 'aggregates', 'beginner', 'COUNT, SUM, AVG, MIN, MAX', 4),
('GROUP BY', 'group-by', 'intermediate', 'Group and summarize data', 5),
('JOINs', 'joins', 'intermediate', 'Combine data from multiple tables', 6),
('Subqueries', 'subqueries', 'intermediate', 'Queries within queries', 7),
('Window Functions', 'window-functions', 'advanced', 'ROW_NUMBER, RANK, LAG, LEAD and more', 8),
('CTEs', 'ctes', 'advanced', 'Common Table Expressions for cleaner queries', 9),
('Query Optimization', 'optimization', 'advanced', 'Write efficient queries using EXPLAIN', 10);

-- Challenges
INSERT INTO challenges (category_id, title, description, hint, starter_code, solution, dataset, difficulty, order_index) VALUES

-- SELECT Basics
(1, 'Select All Customers', 'Retrieve all columns from the customers table.', 'Use SELECT * to get all columns.', '-- Get all customer data', 'SELECT * FROM customers;', 'ecommerce', 1, 1),

(1, 'Select Specific Columns', 'Get only the first_name, last_name, and email of all customers.', 'List the column names after SELECT, separated by commas.', '-- Get customer names and emails', 'SELECT first_name, last_name, email FROM customers;', 'ecommerce', 1, 2),

(1, 'Employee Names', 'Retrieve the first_name, last_name, and job_title of all employees.', 'Select specific columns from the employees table.', '-- Get employee info', 'SELECT first_name, last_name, job_title FROM employees;', 'hr', 1, 3),

-- WHERE Clause
(2, 'Premium Customers', 'Find all customers who have a premium account (is_premium is true).', 'Use WHERE with is_premium = true.', '-- Find premium customers', 'SELECT * FROM customers WHERE is_premium = true;', 'ecommerce', 1, 1),

(2, 'Finance Department', 'Retrieve the first name, last name, and salary of employees working in the Finance department.', 'You will need to JOIN employees with departments.', '-- Employees in Finance', 'SELECT e.first_name, e.last_name, e.salary FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.name = ''Finance'';', 'hr', 2, 2),

(2, 'High Value Orders', 'Find all orders with a total_amount greater than 500.', 'Use WHERE with the > operator.', '-- Orders over $500', 'SELECT * FROM orders WHERE total_amount > 500;', 'ecommerce', 1, 3),

(2, 'Active Accounts', 'Get all active checking accounts with a balance over 10000.', 'Combine conditions with AND.', '-- Active checking accounts', 'SELECT * FROM accounts WHERE account_type = ''checking'' AND balance > 10000 AND status = ''active'';', 'finance', 2, 4),

-- Sorting and Limiting
(3, 'Top 5 Expensive Products', 'Get the 5 most expensive products, showing name and price.', 'Use ORDER BY with DESC and LIMIT.', '-- Most expensive products', 'SELECT name, price FROM products ORDER BY price DESC LIMIT 5;', 'ecommerce', 1, 1),

(3, 'Newest Customers', 'Find the 3 most recently signed up customers.', 'Order by signup_date descending.', '-- Recent signups', 'SELECT * FROM customers ORDER BY signup_date DESC LIMIT 3;', 'ecommerce', 1, 2),

(3, 'Top Salaries by Department', 'List all employees ordered by department_id, then by salary (highest first).', 'Use multiple columns in ORDER BY.', '-- Sorted employees', 'SELECT * FROM employees ORDER BY department_id ASC, salary DESC;', 'hr', 2, 3),

-- Aggregates
(4, 'Count Products', 'How many products are in the products table?', 'Use COUNT(*).', '-- Count all products', 'SELECT COUNT(*) FROM products;', 'ecommerce', 1, 1),

(4, 'Average Salary', 'What is the average salary across all employees?', 'Use the AVG() function.', '-- Average employee salary', 'SELECT AVG(salary) FROM employees;', 'hr', 1, 2),

(4, 'Total Order Value', 'Calculate the total value of all orders.', 'Use SUM() on total_amount.', '-- Total sales', 'SELECT SUM(total_amount) FROM orders;', 'ecommerce', 1, 3),

(4, 'Price Range', 'Find the minimum and maximum product prices.', 'Use MIN() and MAX() together.', '-- Price range', 'SELECT MIN(price) as min_price, MAX(price) as max_price FROM products;', 'ecommerce', 1, 4),

-- GROUP BY
(5, 'Products per Category', 'Count how many products are in each category.', 'GROUP BY category and use COUNT().', '-- Products by category', 'SELECT category, COUNT(*) as product_count FROM products GROUP BY category;', 'ecommerce', 2, 1),

(5, 'Department Salaries', 'Calculate the total salary expense for each department.', 'JOIN with departments and GROUP BY.', '-- Salary by department', 'SELECT d.name, SUM(e.salary) as total_salary FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.name;', 'hr', 3, 2),

(5, 'Orders per Status', 'Count orders by their status.', 'GROUP BY status.', '-- Order status counts', 'SELECT status, COUNT(*) as order_count FROM orders GROUP BY status ORDER BY order_count DESC;', 'ecommerce', 2, 3),

(5, 'High Spending Categories', 'Find categories where customers have spent over $1000 total. Show category and total spent.', 'Use GROUP BY with HAVING.', '-- Big spending categories', 'SELECT p.category, SUM(oi.unit_price * oi.quantity) as total_spent FROM order_items oi JOIN products p ON oi.product_id = p.product_id GROUP BY p.category HAVING SUM(oi.unit_price * oi.quantity) > 1000;', 'ecommerce', 3, 4),

-- JOINs
(6, 'Orders with Customer Names', 'List all orders with the customer first_name and last_name.', 'JOIN orders with customers.', '-- Orders with names', 'SELECT o.order_id, c.first_name, c.last_name, o.total_amount, o.order_date FROM orders o JOIN customers c ON o.customer_id = c.customer_id;', 'ecommerce', 2, 1),

(6, 'Employee Managers', 'Show each employee name alongside their manager name.', 'Use a self-join on employees.', '-- Employee and manager', 'SELECT e.first_name as employee_first, e.last_name as employee_last, m.first_name as manager_first, m.last_name as manager_last FROM employees e LEFT JOIN employees m ON e.manager_id = m.employee_id;', 'hr', 3, 2),

(6, 'Products Never Ordered', 'Find products that have never been ordered.', 'Use LEFT JOIN and check for NULL.', '-- Unordered products', 'SELECT p.* FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id WHERE oi.item_id IS NULL;', 'ecommerce', 3, 3),

(6, 'Account Transaction Summary', 'For each account, show account_number, customer_name, and total transaction amount.', 'JOIN accounts with transactions and aggregate.', '-- Account summaries', 'SELECT a.account_number, a.customer_name, COALESCE(SUM(t.amount), 0) as total_transactions FROM accounts a LEFT JOIN transactions t ON a.account_id = t.account_id GROUP BY a.account_id, a.account_number, a.customer_name;', 'finance', 3, 4),

-- Subqueries
(7, 'Above Average Salary', 'Find employees who earn more than the average salary.', 'Use a subquery to calculate average in WHERE.', '-- High earners', 'SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);', 'hr', 3, 1),

(7, 'Customers with Orders', 'Find customers who have placed at least one order.', 'Use IN with a subquery.', '-- Active customers', 'SELECT * FROM customers WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);', 'ecommerce', 2, 2),

(7, 'Most Expensive Product Orders', 'Find all orders that contain the most expensive product.', 'First find the max price product, then find its orders.', '-- Premium product orders', 'SELECT DISTINCT o.* FROM orders o JOIN order_items oi ON o.order_id = oi.order_id WHERE oi.product_id = (SELECT product_id FROM products ORDER BY price DESC LIMIT 1);', 'ecommerce', 3, 3),

-- Window Functions
(8, 'Rank Employees by Salary', 'Rank all employees by salary within their department, highest first.', 'Use RANK() with PARTITION BY department_id.', '-- Salary ranking', 'SELECT first_name, last_name, department_id, salary, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as salary_rank FROM employees;', 'hr', 4, 1),

(8, 'Running Order Total', 'Calculate a running total of order amounts by date.', 'Use SUM() OVER with ORDER BY.', '-- Running total', 'SELECT order_id, order_date, total_amount, SUM(total_amount) OVER (ORDER BY order_date) as running_total FROM orders ORDER BY order_date;', 'ecommerce', 4, 2),

(8, 'Previous Transaction Amount', 'Show each transaction with the previous transaction amount for the same account.', 'Use LAG() window function.', '-- Transaction comparison', 'SELECT transaction_id, account_id, amount, transaction_date, LAG(amount) OVER (PARTITION BY account_id ORDER BY transaction_date) as prev_amount FROM transactions ORDER BY account_id, transaction_date;', 'finance', 4, 3),

(8, 'Top 3 per Category', 'Find the top 3 most expensive products in each category.', 'Use ROW_NUMBER() and filter with a CTE or subquery.', '-- Top products by category', 'WITH ranked AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) as rn FROM products) SELECT * FROM ranked WHERE rn <= 3;', 'ecommerce', 4, 4),

-- CTEs
(9, 'Department Stats CTE', 'Using a CTE, calculate the employee count and average salary for each department.', 'Define a CTE first, then select from it.', '-- Department statistics', 'WITH dept_stats AS (SELECT d.name as department, COUNT(e.employee_id) as emp_count, AVG(e.salary) as avg_salary FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_id, d.name) SELECT * FROM dept_stats ORDER BY avg_salary DESC;', 'hr', 4, 1),

(9, 'Customer Order Summary', 'Use a CTE to find customers with their total order count and total spent.', 'Create a CTE that aggregates orders by customer.', '-- Customer summary', 'WITH customer_orders AS (SELECT customer_id, COUNT(*) as order_count, SUM(total_amount) as total_spent FROM orders GROUP BY customer_id) SELECT c.first_name, c.last_name, COALESCE(co.order_count, 0) as order_count, COALESCE(co.total_spent, 0) as total_spent FROM customers c LEFT JOIN customer_orders co ON c.customer_id = co.customer_id ORDER BY total_spent DESC;', 'ecommerce', 4, 2),

-- Query Optimization
(10, 'Use EXPLAIN', 'Run EXPLAIN on a query that finds orders over $1000. What type of scan does it use?', 'Prefix your SELECT with EXPLAIN.', '-- Analyze this query', 'EXPLAIN SELECT * FROM orders WHERE total_amount > 1000;', 'ecommerce', 4, 1),

(10, 'Index Usage', 'Compare EXPLAIN output for filtering by customer_id (indexed) vs status (check if indexed).', 'Run EXPLAIN on both queries and compare.', '-- Compare index usage', 'EXPLAIN SELECT * FROM orders WHERE customer_id = 1;', 'ecommerce', 5, 2);
