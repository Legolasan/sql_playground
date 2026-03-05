from pydantic import BaseModel
from typing import Optional


class ExecuteQueryRequest(BaseModel):
    query: str
    dataset: str  # ecommerce, hr, finance


class ExplainQueryRequest(BaseModel):
    query: str
    dataset: str


class ValidateQueryRequest(BaseModel):
    query: str
    challenge_id: int


class FeedbackRequest(BaseModel):
    query: str
    challenge_id: Optional[int] = None
    dataset: str
    error_message: Optional[str] = None


class HintRequest(BaseModel):
    challenge_id: int
    hint_level: int = 1  # 1 = subtle, 2 = more direct, 3 = almost solution


class SaveQueryRequest(BaseModel):
    title: str
    query: str
    dataset: str
    notes: Optional[str] = None


class UpdateProgressRequest(BaseModel):
    status: str  # attempted, solved
    solution: Optional[str] = None
