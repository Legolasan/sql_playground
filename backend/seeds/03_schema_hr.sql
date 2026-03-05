-- HR Sandbox Database Schema
-- Run this in hr_sandbox database

-- Departments
CREATE TABLE IF NOT EXISTS departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(15, 2)
);

-- Employees
CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT REFERENCES departments(department_id),
    manager_id INT REFERENCES employees(employee_id),
    job_title VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- Projects
CREATE TABLE IF NOT EXISTS projects (
    project_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15, 2),
    status VARCHAR(50)
);

-- Project Assignments
CREATE TABLE IF NOT EXISTS project_assignments (
    assignment_id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(project_id),
    employee_id INT REFERENCES employees(employee_id),
    role VARCHAR(100),
    hours_allocated INT,
    UNIQUE(project_id, employee_id)
);

-- Salary History
CREATE TABLE IF NOT EXISTS salary_history (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    salary DECIMAL(10, 2) NOT NULL,
    effective_date DATE NOT NULL,
    reason VARCHAR(200)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_employees_dept ON employees(department_id);
CREATE INDEX IF NOT EXISTS idx_employees_manager ON employees(manager_id);
CREATE INDEX IF NOT EXISTS idx_projects_dept ON projects(department_id);
CREATE INDEX IF NOT EXISTS idx_assignments_project ON project_assignments(project_id);
CREATE INDEX IF NOT EXISTS idx_assignments_employee ON project_assignments(employee_id);
CREATE INDEX IF NOT EXISTS idx_salary_history_employee ON salary_history(employee_id);
