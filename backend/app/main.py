from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .config import get_settings
from .routers import execute, challenges, feedback, progress, schema

settings = get_settings()

app = FastAPI(
    title="SQL Playground API",
    description="Learn SQL with interactive challenges and AI-powered feedback",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(execute.router, prefix="/api", tags=["Query Execution"])
app.include_router(challenges.router, prefix="/api", tags=["Challenges"])
app.include_router(feedback.router, prefix="/api", tags=["AI Feedback"])
app.include_router(progress.router, prefix="/api", tags=["Progress"])
app.include_router(schema.router, prefix="/api", tags=["Schema"])


@app.get("/")
async def root():
    return {"message": "SQL Playground API", "status": "running"}


@app.get("/health")
async def health_check():
    return {"status": "healthy"}
