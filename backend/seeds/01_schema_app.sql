-- SQL Playground App Database Schema
-- Run this in sql_playground_app database

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL DEFAULT 'default_user',
    created_at TIMESTAMP DEFAULT NOW()
);

-- Insert default user
INSERT INTO users (username) VALUES ('default_user') ON CONFLICT (username) DO NOTHING;

-- Categories
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    difficulty VARCHAR(20) NOT NULL,
    description TEXT,
    order_index INT NOT NULL
);

-- Challenges
CREATE TABLE IF NOT EXISTS challenges (
    id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(id),
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    hint TEXT,
    starter_code TEXT,
    solution TEXT NOT NULL,
    expected_output JSONB,
    dataset VARCHAR(50) NOT NULL,
    difficulty INT DEFAULT 1,
    order_index INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Progress tracking
CREATE TABLE IF NOT EXISTS progress (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) DEFAULT 1,
    challenge_id INT REFERENCES challenges(id),
    status VARCHAR(20) NOT NULL DEFAULT 'not_started',
    attempts INT DEFAULT 0,
    best_solution TEXT,
    solved_at TIMESTAMP,
    UNIQUE(user_id, challenge_id)
);

-- Saved queries
CREATE TABLE IF NOT EXISTS saved_queries (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) DEFAULT 1,
    title VARCHAR(200) NOT NULL,
    query TEXT NOT NULL,
    dataset VARCHAR(50) NOT NULL,
    notes TEXT,
    is_bookmarked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Query history
CREATE TABLE IF NOT EXISTS query_history (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) DEFAULT 1,
    query TEXT NOT NULL,
    dataset VARCHAR(50) NOT NULL,
    execution_time_ms INT,
    row_count INT,
    was_successful BOOLEAN,
    error_message TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_progress_user ON progress(user_id);
CREATE INDEX IF NOT EXISTS idx_progress_challenge ON progress(challenge_id);
CREATE INDEX IF NOT EXISTS idx_history_user ON query_history(user_id);
CREATE INDEX IF NOT EXISTS idx_history_created ON query_history(created_at);
