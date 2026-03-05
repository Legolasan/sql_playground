from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey, JSON
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from ..database import Base


class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    slug = Column(String(100), unique=True, nullable=False)
    difficulty = Column(String(20), nullable=False)  # beginner, intermediate, advanced
    order_index = Column(Integer, nullable=False)
    description = Column(Text)

    challenges = relationship("Challenge", back_populates="category")


class Challenge(Base):
    __tablename__ = "challenges"

    id = Column(Integer, primary_key=True, index=True)
    category_id = Column(Integer, ForeignKey("categories.id"))
    title = Column(String(200), nullable=False)
    description = Column(Text, nullable=False)
    hint = Column(Text)
    starter_code = Column(Text)
    solution = Column(Text, nullable=False)
    expected_output = Column(JSON)
    dataset = Column(String(50), nullable=False)  # ecommerce, hr, finance
    difficulty = Column(Integer, default=1)  # 1-5 stars
    order_index = Column(Integer, nullable=False)
    created_at = Column(DateTime, server_default=func.now())

    category = relationship("Category", back_populates="challenges")
