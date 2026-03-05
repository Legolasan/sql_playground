from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from sqlalchemy import func
from typing import Optional
from ..database import get_db
from ..models import Challenge, Category
from ..schemas import ChallengeResponse, CategoryResponse

router = APIRouter()


@router.get("/challenges", response_model=list[ChallengeResponse])
async def list_challenges(
    category: Optional[str] = Query(None, description="Filter by category slug"),
    difficulty: Optional[int] = Query(None, ge=1, le=5, description="Filter by difficulty"),
    dataset: Optional[str] = Query(None, description="Filter by dataset"),
    db: Session = Depends(get_db)
):
    """List all challenges with optional filters."""
    query = db.query(Challenge, Category).join(Category)

    if category:
        query = query.filter(Category.slug == category)
    if difficulty:
        query = query.filter(Challenge.difficulty == difficulty)
    if dataset:
        query = query.filter(Challenge.dataset == dataset)

    query = query.order_by(Category.order_index, Challenge.order_index)

    results = []
    for challenge, cat in query.all():
        results.append(ChallengeResponse(
            id=challenge.id,
            title=challenge.title,
            description=challenge.description,
            hint=challenge.hint,
            starter_code=challenge.starter_code,
            dataset=challenge.dataset,
            difficulty=challenge.difficulty,
            category_name=cat.name,
            category_slug=cat.slug
        ))

    return results


@router.get("/challenges/{challenge_id}", response_model=ChallengeResponse)
async def get_challenge(challenge_id: int, db: Session = Depends(get_db)):
    """Get a specific challenge by ID."""
    result = db.query(Challenge, Category).join(Category).filter(
        Challenge.id == challenge_id
    ).first()

    if not result:
        raise HTTPException(status_code=404, detail="Challenge not found")

    challenge, cat = result
    return ChallengeResponse(
        id=challenge.id,
        title=challenge.title,
        description=challenge.description,
        hint=challenge.hint,
        starter_code=challenge.starter_code,
        dataset=challenge.dataset,
        difficulty=challenge.difficulty,
        category_name=cat.name,
        category_slug=cat.slug
    )


@router.get("/categories", response_model=list[CategoryResponse])
async def list_categories(db: Session = Depends(get_db)):
    """List all challenge categories."""
    results = db.query(
        Category,
        func.count(Challenge.id).label("challenge_count")
    ).outerjoin(Challenge).group_by(Category.id).order_by(Category.order_index).all()

    return [
        CategoryResponse(
            id=cat.id,
            name=cat.name,
            slug=cat.slug,
            difficulty=cat.difficulty,
            challenge_count=count
        )
        for cat, count in results
    ]
