from pydantic_settings import BaseSettings
from functools import lru_cache


class Settings(BaseSettings):
    # Database
    DATABASE_URL: str = "postgresql://postgres:postgres@localhost:5432/sql_playground_app"
    SANDBOX_ECOMMERCE_URL: str = "postgresql://postgres:postgres@localhost:5432/ecommerce_sandbox"
    SANDBOX_HR_URL: str = "postgresql://postgres:postgres@localhost:5432/hr_sandbox"
    SANDBOX_FINANCE_URL: str = "postgresql://postgres:postgres@localhost:5432/finance_sandbox"

    # OpenAI
    OPENAI_API_KEY: str = ""

    # App
    DEBUG: bool = True
    CORS_ORIGINS: list[str] = ["http://localhost:5173", "http://localhost:3000"]

    # Query limits
    MAX_QUERY_ROWS: int = 1000
    QUERY_TIMEOUT_SECONDS: int = 30

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


@lru_cache()
def get_settings() -> Settings:
    return Settings()
