from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import QueuePool
from .config import get_settings

settings = get_settings()

# Main app database engine
engine = create_engine(
    settings.DATABASE_URL,
    poolclass=QueuePool,
    pool_size=5,
    max_overflow=10,
    pool_pre_ping=True
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Sandbox database engines
sandbox_engines = {
    "ecommerce": create_engine(settings.SANDBOX_ECOMMERCE_URL, pool_pre_ping=True),
    "hr": create_engine(settings.SANDBOX_HR_URL, pool_pre_ping=True),
    "finance": create_engine(settings.SANDBOX_FINANCE_URL, pool_pre_ping=True),
}


def get_db():
    """Dependency for main app database session."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_sandbox_engine(dataset: str):
    """Get the appropriate sandbox engine for a dataset."""
    if dataset not in sandbox_engines:
        raise ValueError(f"Unknown dataset: {dataset}")
    return sandbox_engines[dataset]
