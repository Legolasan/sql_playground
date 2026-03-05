from pydantic import BaseModel
from typing import Optional, Any
from datetime import datetime


class QueryResult(BaseModel):
    success: bool
    columns: list[str] = []
    rows: list[list[Any]] = []
    row_count: int = 0
    execution_time_ms: int = 0
    error: Optional[str] = None


class ExplainResult(BaseModel):
    success: bool
    plan: list[dict] = []
    plan_text: str = ""
    total_cost: Optional[float] = None
    execution_time_ms: Optional[float] = None
    error: Optional[str] = None


class ValidationResult(BaseModel):
    is_correct: bool
    expected_columns: list[str] = []
    actual_columns: list[str] = []
    expected_row_count: int = 0
    actual_row_count: int = 0
    feedback: str = ""


class FeedbackResponse(BaseModel):
    feedback: str
    suggestions: list[str] = []
    optimizations: list[str] = []
    is_correct: Optional[bool] = None


class ChallengeResponse(BaseModel):
    id: int
    title: str
    description: str
    hint: Optional[str]
    starter_code: Optional[str]
    dataset: str
    difficulty: int
    category_name: str
    category_slug: str


class CategoryResponse(BaseModel):
    id: int
    name: str
    slug: str
    difficulty: str
    challenge_count: int


class ProgressResponse(BaseModel):
    challenge_id: int
    status: str
    attempts: int
    solved_at: Optional[datetime]


class StatsResponse(BaseModel):
    total_challenges: int
    solved: int
    attempted: int
    total_queries_run: int
    streak_days: int


class SavedQueryResponse(BaseModel):
    id: int
    title: str
    query: str
    dataset: str
    notes: Optional[str]
    is_bookmarked: bool
    created_at: datetime


class TableSchema(BaseModel):
    table_name: str
    columns: list[dict]  # name, type, nullable, primary_key


class DatasetSchema(BaseModel):
    dataset: str
    tables: list[TableSchema]
