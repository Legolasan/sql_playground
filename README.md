# SQL Playground

An interactive SQL learning platform with challenge-based learning, AI-powered feedback, and query execution analysis.

## Features

- **Interactive SQL Editor** - Monaco-powered editor with syntax highlighting
- **Challenge-based Learning** - Beginner to advanced challenges across multiple datasets
- **AI Feedback** - Get intelligent suggestions and optimizations from GPT-4
- **EXPLAIN Analysis** - Understand query execution plans
- **Progress Tracking** - Track your learning journey
- **Multiple Datasets** - E-commerce, HR, and Finance scenarios

## Tech Stack

- **Frontend**: React 18, Vite, TailwindCSS, Monaco Editor, Zustand
- **Backend**: FastAPI, SQLAlchemy, PostgreSQL
- **AI**: OpenAI GPT-4

## Setup

### Prerequisites

- Node.js 18+
- Python 3.10+
- PostgreSQL 14+

### Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Copy environment file
cp .env.example .env
# Edit .env with your database and OpenAI credentials

# Run the server
uvicorn app.main:app --reload --port 8000
```

### Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Run dev server
npm run dev
```

### Database Setup

1. Create the required databases:

```sql
CREATE DATABASE sql_playground_app;
CREATE DATABASE ecommerce_sandbox;
CREATE DATABASE hr_sandbox;
CREATE DATABASE finance_sandbox;
```

2. Run the seed files in order:

```bash
# App database
psql -d sql_playground_app -f backend/seeds/01_schema_app.sql
psql -d sql_playground_app -f backend/seeds/08_challenges.sql

# Sandbox databases
psql -d ecommerce_sandbox -f backend/seeds/02_schema_ecommerce.sql
psql -d ecommerce_sandbox -f backend/seeds/05_data_ecommerce.sql

psql -d hr_sandbox -f backend/seeds/03_schema_hr.sql
psql -d hr_sandbox -f backend/seeds/06_data_hr.sql

psql -d finance_sandbox -f backend/seeds/04_schema_finance.sql
psql -d finance_sandbox -f backend/seeds/07_data_finance.sql
```

## Development

- Frontend runs on `http://localhost:5173`
- Backend runs on `http://localhost:8000`
- API docs at `http://localhost:8000/docs`

## License

MIT
