from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas import FeedbackRequest, HintRequest, FeedbackResponse, ValidateQueryRequest, ValidationResult
from ..services import get_query_feedback, get_hint, execute_query
from ..models import Challenge

router = APIRouter()


@router.post("/feedback", response_model=FeedbackResponse)
async def get_feedback(request: FeedbackRequest, db: Session = Depends(get_db)):
    """Get AI feedback on a SQL query."""
    challenge_description = None

    if request.challenge_id:
        challenge = db.query(Challenge).filter(Challenge.id == request.challenge_id).first()
        if challenge:
            challenge_description = challenge.description

    return get_query_feedback(
        query=request.query,
        dataset=request.dataset,
        challenge_description=challenge_description,
        error_message=request.error_message
    )


@router.post("/hint")
async def request_hint(request: HintRequest, db: Session = Depends(get_db)):
    """Get a hint for a challenge."""
    challenge = db.query(Challenge).filter(Challenge.id == request.challenge_id).first()

    if not challenge:
        raise HTTPException(status_code=404, detail="Challenge not found")

    hint = get_hint(challenge.description, request.hint_level)
    return {"hint": hint, "level": request.hint_level}


@router.post("/validate", response_model=ValidationResult)
async def validate_query(request: ValidateQueryRequest, db: Session = Depends(get_db)):
    """Validate if a query produces the expected output for a challenge."""
    challenge = db.query(Challenge).filter(Challenge.id == request.challenge_id).first()

    if not challenge:
        raise HTTPException(status_code=404, detail="Challenge not found")

    # Execute user's query
    user_result = execute_query(request.query, challenge.dataset)

    if not user_result.success:
        return ValidationResult(
            is_correct=False,
            feedback=f"Query error: {user_result.error}"
        )

    # Execute the solution to compare
    solution_result = execute_query(challenge.solution, challenge.dataset)

    if not solution_result.success:
        return ValidationResult(
            is_correct=False,
            feedback="Error validating against solution. Please contact support."
        )

    # Compare results
    columns_match = set(user_result.columns) == set(solution_result.columns)
    rows_match = user_result.row_count == solution_result.row_count

    # Sort both results for comparison
    user_rows_sorted = sorted([tuple(row) for row in user_result.rows])
    solution_rows_sorted = sorted([tuple(row) for row in solution_result.rows])
    data_match = user_rows_sorted == solution_rows_sorted

    is_correct = columns_match and data_match

    feedback = []
    if not columns_match:
        feedback.append(f"Column mismatch. Expected: {solution_result.columns}, Got: {user_result.columns}")
    if not rows_match:
        feedback.append(f"Row count mismatch. Expected: {solution_result.row_count}, Got: {user_result.row_count}")
    if columns_match and rows_match and not data_match:
        feedback.append("Data values don't match the expected output.")

    if is_correct:
        feedback = ["Correct! Your query produces the expected output."]

    return ValidationResult(
        is_correct=is_correct,
        expected_columns=solution_result.columns,
        actual_columns=user_result.columns,
        expected_row_count=solution_result.row_count,
        actual_row_count=user_result.row_count,
        feedback=" ".join(feedback)
    )
