from openai import OpenAI
from ..config import get_settings
from ..schemas import FeedbackResponse

settings = get_settings()


def get_openai_client():
    """Get OpenAI client."""
    return OpenAI(api_key=settings.OPENAI_API_KEY)


def get_query_feedback(
    query: str,
    dataset: str,
    challenge_description: str = None,
    expected_result: str = None,
    actual_result: str = None,
    error_message: str = None
) -> FeedbackResponse:
    """Get AI feedback on a SQL query."""

    if not settings.OPENAI_API_KEY:
        return FeedbackResponse(
            feedback="AI feedback is not configured. Please add your OpenAI API key.",
            suggestions=[],
            optimizations=[]
        )

    try:
        client = get_openai_client()

        # Build context
        context_parts = [
            f"Dataset: {dataset}",
            f"User's SQL Query:\n```sql\n{query}\n```"
        ]

        if challenge_description:
            context_parts.insert(1, f"Challenge: {challenge_description}")

        if error_message:
            context_parts.append(f"Error encountered: {error_message}")

        if actual_result:
            context_parts.append(f"Query returned {actual_result}")

        context = "\n\n".join(context_parts)

        prompt = f"""You are a SQL tutor helping someone learn PostgreSQL. Analyze their query and provide helpful feedback.

{context}

Provide:
1. Is the query correct for the task? (if a challenge was given)
2. Any syntax or logical errors
3. Suggestions for improvement
4. Performance optimization tips if applicable

Be encouraging but precise. Keep feedback concise and actionable.
Format your response as JSON with these fields:
- feedback: main feedback message (string)
- suggestions: list of improvement suggestions (array of strings)
- optimizations: list of performance tips (array of strings)
- is_correct: whether the query solves the challenge (boolean or null if no challenge)"""

        response = client.chat.completions.create(
            model="gpt-4-turbo-preview",
            messages=[
                {"role": "system", "content": "You are a helpful SQL tutor. Respond with valid JSON only."},
                {"role": "user", "content": prompt}
            ],
            response_format={"type": "json_object"},
            max_tokens=1000
        )

        import json
        result = json.loads(response.choices[0].message.content)

        return FeedbackResponse(
            feedback=result.get("feedback", ""),
            suggestions=result.get("suggestions", []),
            optimizations=result.get("optimizations", []),
            is_correct=result.get("is_correct")
        )

    except Exception as e:
        return FeedbackResponse(
            feedback=f"Error getting AI feedback: {str(e)}",
            suggestions=[],
            optimizations=[]
        )


def get_hint(challenge_description: str, hint_level: int = 1) -> str:
    """Get a hint for a challenge."""

    if not settings.OPENAI_API_KEY:
        return "AI hints are not configured. Please add your OpenAI API key."

    try:
        client = get_openai_client()

        level_instructions = {
            1: "Give a subtle hint that points in the right direction without revealing the solution. Just mention a concept or keyword to look into.",
            2: "Give a more direct hint that explains the approach needed, mentioning specific SQL clauses or functions to use.",
            3: "Give a detailed hint that almost reveals the solution structure, but still requires the user to write the actual query."
        }

        prompt = f"""You are a SQL tutor. The student is stuck on this challenge:

{challenge_description}

{level_instructions.get(hint_level, level_instructions[1])}

Keep the hint concise (1-3 sentences max)."""

        response = client.chat.completions.create(
            model="gpt-4-turbo-preview",
            messages=[
                {"role": "system", "content": "You are a helpful SQL tutor giving hints."},
                {"role": "user", "content": prompt}
            ],
            max_tokens=200
        )

        return response.choices[0].message.content

    except Exception as e:
        return f"Error getting hint: {str(e)}"
