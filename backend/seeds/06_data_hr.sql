-- HR Sample Data

-- Departments
INSERT INTO departments (name, location, budget) VALUES
('Engineering', 'Building A', 2500000.00),
('Marketing', 'Building B', 1200000.00),
('Finance', 'Building A', 800000.00),
('Human Resources', 'Building C', 500000.00),
('Sales', 'Building B', 1500000.00),
('Product', 'Building A', 1000000.00),
('Operations', 'Building C', 750000.00),
('Legal', 'Building A', 600000.00);

-- Employees
INSERT INTO employees (first_name, last_name, email, department_id, manager_id, job_title, salary, hire_date, is_active) VALUES
('Alice', 'Chen', 'alice.chen@company.com', 1, NULL, 'VP of Engineering', 250000.00, '2019-03-15', true),
('Bob', 'Kumar', 'bob.kumar@company.com', 1, 1, 'Engineering Manager', 180000.00, '2020-06-01', true),
('Carol', 'Williams', 'carol.w@company.com', 1, 2, 'Senior Software Engineer', 150000.00, '2021-01-10', true),
('David', 'Lee', 'david.lee@company.com', 1, 2, 'Software Engineer', 120000.00, '2022-03-20', true),
('Eva', 'Martinez', 'eva.m@company.com', 1, 2, 'Software Engineer', 115000.00, '2022-08-15', true),
('Frank', 'Johnson', 'frank.j@company.com', 2, NULL, 'VP of Marketing', 220000.00, '2019-05-01', true),
('Grace', 'Taylor', 'grace.t@company.com', 2, 6, 'Marketing Manager', 130000.00, '2020-09-15', true),
('Henry', 'Brown', 'henry.b@company.com', 2, 7, 'Marketing Specialist', 85000.00, '2021-11-01', true),
('Ivy', 'Davis', 'ivy.d@company.com', 3, NULL, 'CFO', 280000.00, '2018-01-15', true),
('Jack', 'Wilson', 'jack.w@company.com', 3, 9, 'Finance Manager', 140000.00, '2020-02-01', true),
('Kate', 'Anderson', 'kate.a@company.com', 3, 10, 'Financial Analyst', 95000.00, '2021-06-15', true),
('Leo', 'Thomas', 'leo.t@company.com', 4, NULL, 'HR Director', 160000.00, '2019-08-01', true),
('Mia', 'Jackson', 'mia.j@company.com', 4, 12, 'HR Manager', 100000.00, '2021-03-01', true),
('Noah', 'White', 'noah.w@company.com', 5, NULL, 'VP of Sales', 230000.00, '2019-04-15', true),
('Olivia', 'Harris', 'olivia.h@company.com', 5, 14, 'Sales Manager', 140000.00, '2020-07-01', true),
('Peter', 'Clark', 'peter.c@company.com', 5, 15, 'Sales Representative', 75000.00, '2022-01-10', true),
('Quinn', 'Lewis', 'quinn.l@company.com', 5, 15, 'Sales Representative', 72000.00, '2022-05-20', true),
('Rachel', 'Walker', 'rachel.w@company.com', 6, NULL, 'VP of Product', 240000.00, '2019-06-01', true),
('Sam', 'Hall', 'sam.h@company.com', 6, 18, 'Product Manager', 145000.00, '2020-11-15', true),
('Tina', 'Allen', 'tina.a@company.com', 6, 19, 'Product Analyst', 100000.00, '2021-09-01', true),
('Uma', 'Young', 'uma.y@company.com', 1, 2, 'Junior Developer', 80000.00, '2023-06-01', true),
('Victor', 'King', 'victor.k@company.com', 1, 3, 'DevOps Engineer', 135000.00, '2021-07-15', true),
('Wendy', 'Scott', 'wendy.s@company.com', 7, NULL, 'COO', 260000.00, '2018-09-01', true),
('Xavier', 'Green', 'xavier.g@company.com', 7, 23, 'Operations Manager', 120000.00, '2020-04-01', true),
('Yolanda', 'Adams', 'yolanda.a@company.com', 8, NULL, 'General Counsel', 200000.00, '2019-10-15', true);

-- Projects
INSERT INTO projects (name, department_id, start_date, end_date, budget, status) VALUES
('Platform Redesign', 1, '2024-01-01', '2024-06-30', 500000.00, 'active'),
('Mobile App v2', 1, '2024-02-15', '2024-08-15', 350000.00, 'active'),
('Brand Refresh', 2, '2024-01-15', '2024-04-30', 150000.00, 'active'),
('Q1 Campaign', 2, '2024-01-01', '2024-03-31', 200000.00, 'completed'),
('Annual Audit', 3, '2024-01-01', '2024-02-28', 50000.00, 'completed'),
('Hiring Initiative', 4, '2024-01-01', '2024-12-31', 100000.00, 'active'),
('CRM Integration', 5, '2024-03-01', '2024-07-31', 250000.00, 'planning'),
('Feature Launch', 6, '2024-02-01', '2024-05-31', 300000.00, 'active');

-- Project Assignments
INSERT INTO project_assignments (project_id, employee_id, role, hours_allocated) VALUES
(1, 2, 'Project Lead', 400),
(1, 3, 'Senior Developer', 500),
(1, 4, 'Developer', 600),
(1, 5, 'Developer', 600),
(1, 22, 'DevOps', 200),
(2, 2, 'Project Lead', 300),
(2, 4, 'Developer', 400),
(2, 21, 'Junior Developer', 500),
(3, 7, 'Project Lead', 300),
(3, 8, 'Specialist', 400),
(4, 6, 'Executive Sponsor', 50),
(4, 7, 'Project Lead', 200),
(4, 8, 'Specialist', 300),
(5, 10, 'Project Lead', 150),
(5, 11, 'Analyst', 200),
(6, 12, 'Project Lead', 200),
(6, 13, 'HR Manager', 400),
(7, 15, 'Project Lead', 300),
(7, 16, 'Sales Rep', 200),
(7, 17, 'Sales Rep', 200),
(8, 19, 'Project Lead', 350),
(8, 20, 'Analyst', 400);

-- Salary History
INSERT INTO salary_history (employee_id, salary, effective_date, reason) VALUES
(1, 200000.00, '2019-03-15', 'Initial hire'),
(1, 220000.00, '2020-03-15', 'Annual raise'),
(1, 250000.00, '2022-03-15', 'Promotion'),
(3, 120000.00, '2021-01-10', 'Initial hire'),
(3, 135000.00, '2022-01-10', 'Annual raise'),
(3, 150000.00, '2023-01-10', 'Promotion'),
(4, 100000.00, '2022-03-20', 'Initial hire'),
(4, 110000.00, '2023-03-20', 'Annual raise'),
(4, 120000.00, '2024-03-20', 'Annual raise'),
(21, 75000.00, '2023-06-01', 'Initial hire'),
(21, 80000.00, '2024-01-01', 'Performance bonus');
