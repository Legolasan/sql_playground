import time
import re
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from ..database import get_sandbox_engine
from ..schemas import QueryResult, ExplainResult
from ..config import get_settings

settings = get_settings()

# Dangerous keywords that could modify data or schema
FORBIDDEN_KEYWORDS = [
    r'\bDROP\b', r'\bDELETE\b', r'\bTRUNCATE\b', r'\bALTER\b',
    r'\bCREATE\b', r'\bINSERT\b', r'\bUPDATE\b', r'\bGRANT\b',
    r'\bREVOKE\b', r'\bEXEC\b', r'\bEXECUTE\b', r'\bCOPY\b',
    r'\bVACUUM\b', r'\bREINDEX\b', r'\bCLUSTER\b', r'\bCOMMENT\b'
]


def is_safe_query(query: str) -> tuple[bool, str]:
    """Check if query is safe (SELECT only)."""
    query_upper = query.upper().strip()

    # Must start with SELECT, WITH, or EXPLAIN
    if not re.match(r'^(SELECT|WITH|EXPLAIN)\b', query_upper):
        return False, "Only SELECT queries are allowed"

    # Check for forbidden keywords
    for pattern in FORBIDDEN_KEYWORDS:
        if re.search(pattern, query_upper):
            keyword = re.search(pattern, query_upper).group()
            return False, f"Query contains forbidden keyword: {keyword}"

    return True, ""


def execute_query(query: str, dataset: str) -> QueryResult:
    """Execute a query against the sandbox database."""
    start_time = time.time()

    # Safety check
    is_safe, error_msg = is_safe_query(query)
    if not is_safe:
        return QueryResult(success=False, error=error_msg)

    try:
        engine = get_sandbox_engine(dataset)

        with engine.connect() as conn:
            # Set statement timeout
            conn.execute(text(f"SET statement_timeout = '{settings.QUERY_TIMEOUT_SECONDS}s'"))

            result = conn.execute(text(query))

            columns = list(result.keys())
            rows = [list(row) for row in result.fetchmany(settings.MAX_QUERY_ROWS)]
            row_count = len(rows)

            execution_time = int((time.time() - start_time) * 1000)

            return QueryResult(
                success=True,
                columns=columns,
                rows=rows,
                row_count=row_count,
                execution_time_ms=execution_time
            )

    except SQLAlchemyError as e:
        error_message = str(e.orig) if hasattr(e, 'orig') else str(e)
        return QueryResult(success=False, error=error_message)
    except Exception as e:
        return QueryResult(success=False, error=str(e))


def explain_query(query: str, dataset: str) -> ExplainResult:
    """Get EXPLAIN ANALYZE output for a query."""
    start_time = time.time()

    # Safety check on original query
    is_safe, error_msg = is_safe_query(query)
    if not is_safe:
        return ExplainResult(success=False, error=error_msg)

    try:
        engine = get_sandbox_engine(dataset)

        # Build EXPLAIN ANALYZE query
        explain_query = f"EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) {query}"

        with engine.connect() as conn:
            conn.execute(text(f"SET statement_timeout = '{settings.QUERY_TIMEOUT_SECONDS}s'"))

            result = conn.execute(text(explain_query))
            plan_json = result.fetchone()[0]

            # Also get text format for display
            text_result = conn.execute(text(f"EXPLAIN ANALYZE {query}"))
            plan_text = "\n".join([row[0] for row in text_result.fetchall()])

            execution_time = int((time.time() - start_time) * 1000)

            # Extract total cost
            total_cost = None
            if plan_json and len(plan_json) > 0:
                total_cost = plan_json[0].get("Plan", {}).get("Total Cost")

            return ExplainResult(
                success=True,
                plan=plan_json,
                plan_text=plan_text,
                total_cost=total_cost,
                execution_time_ms=execution_time
            )

    except SQLAlchemyError as e:
        error_message = str(e.orig) if hasattr(e, 'orig') else str(e)
        return ExplainResult(success=False, error=error_message)
    except Exception as e:
        return ExplainResult(success=False, error=str(e))
