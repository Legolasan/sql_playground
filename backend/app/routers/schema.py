from fastapi import APIRouter, HTTPException
from sqlalchemy import text, inspect
from ..database import get_sandbox_engine
from ..schemas import TableSchema, DatasetSchema

router = APIRouter()


@router.get("/schema/{dataset}", response_model=DatasetSchema)
async def get_schema(dataset: str):
    """Get the schema for a dataset."""
    try:
        engine = get_sandbox_engine(dataset)
    except ValueError:
        raise HTTPException(status_code=404, detail=f"Dataset '{dataset}' not found")

    inspector = inspect(engine)
    tables = []

    for table_name in inspector.get_table_names():
        columns = []
        pk_columns = [col["name"] for col in inspector.get_pk_constraint(table_name).get("constrained_columns", [])]

        for column in inspector.get_columns(table_name):
            columns.append({
                "name": column["name"],
                "type": str(column["type"]),
                "nullable": column["nullable"],
                "primary_key": column["name"] in pk_columns
            })

        tables.append(TableSchema(
            table_name=table_name,
            columns=columns
        ))

    return DatasetSchema(dataset=dataset, tables=tables)


@router.get("/tables/{dataset}")
async def list_tables(dataset: str):
    """List all tables in a dataset."""
    try:
        engine = get_sandbox_engine(dataset)
    except ValueError:
        raise HTTPException(status_code=404, detail=f"Dataset '{dataset}' not found")

    inspector = inspect(engine)
    tables = inspector.get_table_names()

    return {"dataset": dataset, "tables": tables}


@router.get("/table/{dataset}/{table_name}")
async def get_table_info(dataset: str, table_name: str):
    """Get detailed info about a specific table."""
    try:
        engine = get_sandbox_engine(dataset)
    except ValueError:
        raise HTTPException(status_code=404, detail=f"Dataset '{dataset}' not found")

    inspector = inspect(engine)

    if table_name not in inspector.get_table_names():
        raise HTTPException(status_code=404, detail=f"Table '{table_name}' not found")

    columns = inspector.get_columns(table_name)
    pk_constraint = inspector.get_pk_constraint(table_name)
    foreign_keys = inspector.get_foreign_keys(table_name)
    indexes = inspector.get_indexes(table_name)

    # Get row count
    with engine.connect() as conn:
        result = conn.execute(text(f"SELECT COUNT(*) FROM {table_name}"))
        row_count = result.scalar()

    return {
        "table_name": table_name,
        "columns": columns,
        "primary_key": pk_constraint,
        "foreign_keys": foreign_keys,
        "indexes": indexes,
        "row_count": row_count
    }
