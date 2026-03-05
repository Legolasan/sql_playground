from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey, Boolean
from sqlalchemy.sql import func
from ..database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False, default="default_user")
    created_at = Column(DateTime, server_default=func.now())


class Progress(Base):
    __tablename__ = "progress"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), default=1)
    challenge_id = Column(Integer, ForeignKey("challenges.id"))
    status = Column(String(20), nullable=False, default="not_started")  # not_started, attempted, solved
    attempts = Column(Integer, default=0)
    best_solution = Column(Text)
    solved_at = Column(DateTime)


class SavedQuery(Base):
    __tablename__ = "saved_queries"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), default=1)
    title = Column(String(200), nullable=False)
    query = Column(Text, nullable=False)
    dataset = Column(String(50), nullable=False)
    notes = Column(Text)
    is_bookmarked = Column(Boolean, default=False)
    created_at = Column(DateTime, server_default=func.now())


class QueryHistory(Base):
    __tablename__ = "query_history"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), default=1)
    query = Column(Text, nullable=False)
    dataset = Column(String(50), nullable=False)
    execution_time_ms = Column(Integer)
    row_count = Column(Integer)
    was_successful = Column(Boolean)
    error_message = Column(Text)
    created_at = Column(DateTime, server_default=func.now())
