from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas import ExecuteQueryRequest, ExplainQueryRequest, QueryResult, ExplainResult
from ..services import execute_query, explain_query
from ..models import QueryHistory

router = APIRouter()


@router.post("/execute", response_model=QueryResult)
async def run_query(request: ExecuteQueryRequest, db: Session = Depends(get_db)):
    """Execute a SQL query and return results."""
    result = execute_query(request.query, request.dataset)

    # Log to history
    history = QueryHistory(
        query=request.query,
        dataset=request.dataset,
        execution_time_ms=result.execution_time_ms,
        row_count=result.row_count,
        was_successful=result.success,
        error_message=result.error
    )
    db.add(history)
    db.commit()

    return result


@router.post("/explain", response_model=ExplainResult)
async def explain(request: ExplainQueryRequest):
    """Get EXPLAIN ANALYZE output for a query."""
    return explain_query(request.query, request.dataset)
