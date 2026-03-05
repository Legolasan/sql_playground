from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime
from ..database import get_db
from ..models import Progress, SavedQuery, QueryHistory, Challenge
from ..schemas import (
    UpdateProgressRequest, SaveQueryRequest,
    ProgressResponse, StatsResponse, SavedQueryResponse
)

router = APIRouter()


@router.get("/progress", response_model=list[ProgressResponse])
async def get_progress(db: Session = Depends(get_db)):
    """Get progress for all challenges."""
    progress_list = db.query(Progress).filter(Progress.user_id == 1).all()
    return [
        ProgressResponse(
            challenge_id=p.challenge_id,
            status=p.status,
            attempts=p.attempts,
            solved_at=p.solved_at
        )
        for p in progress_list
    ]


@router.post("/progress/{challenge_id}")
async def update_progress(
    challenge_id: int,
    request: UpdateProgressRequest,
    db: Session = Depends(get_db)
):
    """Update progress for a challenge."""
    progress = db.query(Progress).filter(
        Progress.user_id == 1,
        Progress.challenge_id == challenge_id
    ).first()

    if not progress:
        progress = Progress(
            user_id=1,
            challenge_id=challenge_id,
            status=request.status,
            attempts=1
        )
        db.add(progress)
    else:
        progress.status = request.status
        progress.attempts += 1

    if request.status == "solved":
        progress.solved_at = datetime.utcnow()
        if request.solution:
            progress.best_solution = request.solution

    db.commit()
    return {"message": "Progress updated", "attempts": progress.attempts}


@router.get("/stats", response_model=StatsResponse)
async def get_stats(db: Session = Depends(get_db)):
    """Get learning statistics."""
    total_challenges = db.query(Challenge).count()

    solved = db.query(Progress).filter(
        Progress.user_id == 1,
        Progress.status == "solved"
    ).count()

    attempted = db.query(Progress).filter(
        Progress.user_id == 1,
        Progress.status == "attempted"
    ).count()

    total_queries = db.query(QueryHistory).filter(
        QueryHistory.user_id == 1
    ).count()

    # Calculate streak (simplified - days with activity)
    streak = 0  # TODO: implement proper streak calculation

    return StatsResponse(
        total_challenges=total_challenges,
        solved=solved,
        attempted=attempted,
        total_queries_run=total_queries,
        streak_days=streak
    )


# Saved queries endpoints
@router.get("/saved", response_model=list[SavedQueryResponse])
async def list_saved_queries(db: Session = Depends(get_db)):
    """List all saved queries."""
    queries = db.query(SavedQuery).filter(
        SavedQuery.user_id == 1
    ).order_by(SavedQuery.created_at.desc()).all()

    return [
        SavedQueryResponse(
            id=q.id,
            title=q.title,
            query=q.query,
            dataset=q.dataset,
            notes=q.notes,
            is_bookmarked=q.is_bookmarked,
            created_at=q.created_at
        )
        for q in queries
    ]


@router.post("/saved", response_model=SavedQueryResponse)
async def save_query(request: SaveQueryRequest, db: Session = Depends(get_db)):
    """Save a query."""
    saved = SavedQuery(
        user_id=1,
        title=request.title,
        query=request.query,
        dataset=request.dataset,
        notes=request.notes
    )
    db.add(saved)
    db.commit()
    db.refresh(saved)

    return SavedQueryResponse(
        id=saved.id,
        title=saved.title,
        query=saved.query,
        dataset=saved.dataset,
        notes=saved.notes,
        is_bookmarked=saved.is_bookmarked,
        created_at=saved.created_at
    )


@router.delete("/saved/{query_id}")
async def delete_saved_query(query_id: int, db: Session = Depends(get_db)):
    """Delete a saved query."""
    saved = db.query(SavedQuery).filter(
        SavedQuery.id == query_id,
        SavedQuery.user_id == 1
    ).first()

    if not saved:
        raise HTTPException(status_code=404, detail="Query not found")

    db.delete(saved)
    db.commit()
    return {"message": "Query deleted"}


@router.post("/saved/{query_id}/bookmark")
async def toggle_bookmark(query_id: int, db: Session = Depends(get_db)):
    """Toggle bookmark status for a saved query."""
    saved = db.query(SavedQuery).filter(
        SavedQuery.id == query_id,
        SavedQuery.user_id == 1
    ).first()

    if not saved:
        raise HTTPException(status_code=404, detail="Query not found")

    saved.is_bookmarked = not saved.is_bookmarked
    db.commit()

    return {"is_bookmarked": saved.is_bookmarked}
