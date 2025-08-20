"""
Quiz router for the Comrade backend
"""

from datetime import datetime, timedelta
from typing import List, Optional
from fastapi import APIRouter, HTTPException, Depends, Query, status

from models.quiz import (
    Quiz, QuizCreate, QuizUpdate, QuizResponse, QuizWithQuestions,
    Question, QuestionCreate, QuestionResponse, QuestionWithAnswer,
    QuizSubmission, QuizResult, QuizResultResponse, DailyQuizResponse,
    UserAnswer, QuestionType, DifficultyLevel
)
from models.user import UserResponse
from routers.auth_router import get_current_user

router = APIRouter()

# Mock quiz database - replace with real database
mock_quizzes_db = {}
mock_questions_db = {}
mock_quiz_results_db = {}

# Initialize with some mock quiz data
def initialize_mock_quizzes():
    """Initialize mock quiz and question data"""
    # Create mock questions
    questions = [
        {
            "id": "q1",
            "question_text": "Which is the highest military decoration in India?",
            "question_type": QuestionType.MULTIPLE_CHOICE,
            "difficulty": DifficultyLevel.MEDIUM,
            "explanation": "Param Vir Chakra is the highest military decoration awarded for displaying distinguished acts of valor during wartime.",
            "tags": ["military", "awards", "india"],
            "points": 2,
            "quiz_id": None,
            "created_at": datetime.now(),
            "question_data": {
                "options": ["Param Vir Chakra", "Maha Vir Chakra", "Vir Chakra", "Ashoka Chakra"],
                "correct_answer_index": 0
            }
        },
        {
            "id": "q2",
            "question_text": "The Indian Army was established in 1947.",
            "question_type": QuestionType.TRUE_FALSE,
            "difficulty": DifficultyLevel.EASY,
            "explanation": "The Indian Army has its origins in the armies of the East India Company, which eventually became the British Indian Army, and the armies of the princely states, which were merged into the national army after independence in 1947.",
            "tags": ["army", "history", "independence"],
            "points": 1,
            "quiz_id": None,
            "created_at": datetime.now(),
            "question_data": {
                "correct_answer": True
            }
        },
        {
            "id": "q3",
            "question_text": "What does 'LAC' stand for in the context of Indian borders?",
            "question_type": QuestionType.FILL_IN_BLANK,
            "difficulty": DifficultyLevel.MEDIUM,
            "explanation": "LAC stands for Line of Actual Control, which is the effective border between India and China.",
            "tags": ["borders", "china", "geography"],
            "points": 2,
            "quiz_id": None,
            "created_at": datetime.now(),
            "question_data": {
                "correct_answers": ["Line of Actual Control", "line of actual control"]
            }
        },
        {
            "id": "q4",
            "question_text": "Which operation was launched by India in response to the Uri attack?",
            "question_type": QuestionType.MULTIPLE_CHOICE,
            "difficulty": DifficultyLevel.HARD,
            "explanation": "Operation Surgical Strike was conducted by the Indian Army in September 2016 in response to the Uri attack.",
            "tags": ["operations", "uri", "surgical strike"],
            "points": 3,
            "quiz_id": None,
            "created_at": datetime.now(),
            "question_data": {
                "options": ["Operation Surgical Strike", "Operation Vijay", "Operation Parakram", "Operation All Out"],
                "correct_answer_index": 0
            }
        }
    ]
    
    for question in questions:
        mock_questions_db[question["id"]] = question
    
    # Create mock quiz
    daily_quiz = {
        "id": "daily_quiz_1",
        "title": "Daily Defense Knowledge Quiz",
        "description": "Test your knowledge of Indian defense and military affairs",
        "time_limit": 15,  # 15 minutes
        "passing_score": 70,
        "is_daily": True,
        "is_active": True,
        "tags": ["daily", "defense", "military"],
        "created_by": "system",
        "created_at": datetime.now(),
        "updated_at": None,
        "total_questions": 4,
        "total_points": 8
    }
    
    mock_quizzes_db[daily_quiz["id"]] = daily_quiz
    
    # Link questions to quiz
    for question in questions:
        question["quiz_id"] = daily_quiz["id"]

# Initialize mock data
initialize_mock_quizzes()


def get_question_response(question_data: dict, include_answers: bool = False) -> QuestionResponse:
    """Convert question data to response format"""
    if include_answers:
        return QuestionWithAnswer(
            id=question_data["id"],
            question_text=question_data["question_text"],
            question_type=question_data["question_type"],
            difficulty=question_data["difficulty"],
            tags=question_data["tags"],
            points=question_data["points"],
            explanation=question_data.get("explanation"),
            options=question_data["question_data"].get("options"),
            correct_answer_index=question_data["question_data"].get("correct_answer_index"),
            correct_answer=question_data["question_data"].get("correct_answer"),
            correct_answers=question_data["question_data"].get("correct_answers")
        )
    else:
        return QuestionResponse(
            id=question_data["id"],
            question_text=question_data["question_text"],
            question_type=question_data["question_type"],
            difficulty=question_data["difficulty"],
            tags=question_data["tags"],
            points=question_data["points"],
            options=question_data["question_data"].get("options")
        )


@router.get("/daily", response_model=DailyQuizResponse)
async def get_daily_quiz(
    date: Optional[str] = Query(None, description="Date in YYYY-MM-DD format"),
    current_user: UserResponse = Depends(get_current_user)
):
    """Get daily quiz for a specific date"""
    target_date = datetime.now().date()
    if date:
        try:
            target_date = datetime.strptime(date, "%Y-%m-%d").date()
        except ValueError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid date format. Use YYYY-MM-DD"
            )
    
    # Find daily quiz (for simplicity, using the same quiz for all days)
    daily_quiz_data = None
    for quiz_data in mock_quizzes_db.values():
        if quiz_data["is_daily"]:
            daily_quiz_data = quiz_data
            break
    
    if not daily_quiz_data:
        return DailyQuizResponse(
            date=datetime.combine(target_date, datetime.min.time()),
            quiz=None,
            has_attempted=False,
            result=None
        )
    
    # Get quiz questions
    quiz_questions = []
    for question_data in mock_questions_db.values():
        if question_data["quiz_id"] == daily_quiz_data["id"]:
            quiz_questions.append(get_question_response(question_data))
    
    quiz_with_questions = QuizWithQuestions(
        id=daily_quiz_data["id"],
        title=daily_quiz_data["title"],
        description=daily_quiz_data["description"],
        time_limit=daily_quiz_data["time_limit"],
        passing_score=daily_quiz_data["passing_score"],
        is_daily=daily_quiz_data["is_daily"],
        tags=daily_quiz_data["tags"],
        total_questions=daily_quiz_data["total_questions"],
        total_points=daily_quiz_data["total_points"],
        created_at=daily_quiz_data["created_at"],
        questions=quiz_questions
    )
    
    # Check if user has attempted this quiz today
    user_result_key = f"{current_user.id}_{daily_quiz_data['id']}_{target_date}"
    has_attempted = user_result_key in mock_quiz_results_db
    result = None
    
    if has_attempted:
        result_data = mock_quiz_results_db[user_result_key]
        # Get questions with answers for result
        questions_with_answers = []
        for question_data in mock_questions_db.values():
            if question_data["quiz_id"] == daily_quiz_data["id"]:
                questions_with_answers.append(get_question_response(question_data, include_answers=True))
        
        result = QuizResultResponse(
            id=result_data["id"],
            quiz=QuizResponse(**daily_quiz_data),
            score=result_data["score"],
            points_earned=result_data["points_earned"],
            total_points=result_data["total_points"],
            time_taken=result_data["time_taken"],
            passed=result_data["passed"],
            submitted_at=result_data["submitted_at"],
            questions_with_answers=questions_with_answers,
            user_answers=result_data["answers"]
        )
    
    return DailyQuizResponse(
        date=datetime.combine(target_date, datetime.min.time()),
        quiz=quiz_with_questions if not has_attempted else None,
        has_attempted=has_attempted,
        result=result
    )


@router.get("/{quiz_id}", response_model=QuizWithQuestions)
async def get_quiz(
    quiz_id: str,
    current_user: UserResponse = Depends(get_current_user)
):
    """Get quiz by ID with questions"""
    quiz_data = mock_quizzes_db.get(quiz_id)
    if not quiz_data:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Quiz not found"
        )
    
    if not quiz_data["is_active"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Quiz is not active"
        )
    
    # Get quiz questions
    quiz_questions = []
    for question_data in mock_questions_db.values():
        if question_data["quiz_id"] == quiz_id:
            quiz_questions.append(get_question_response(question_data))
    
    return QuizWithQuestions(
        id=quiz_data["id"],
        title=quiz_data["title"],
        description=quiz_data["description"],
        time_limit=quiz_data["time_limit"],
        passing_score=quiz_data["passing_score"],
        is_daily=quiz_data["is_daily"],
        tags=quiz_data["tags"],
        total_questions=quiz_data["total_questions"],
        total_points=quiz_data["total_points"],
        created_at=quiz_data["created_at"],
        questions=quiz_questions
    )


@router.post("/{quiz_id}/submit", response_model=QuizResultResponse)
async def submit_quiz(
    quiz_id: str,
    submission: QuizSubmission,
    current_user: UserResponse = Depends(get_current_user)
):
    """Submit quiz answers and get results"""
    quiz_data = mock_quizzes_db.get(quiz_id)
    if not quiz_data:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Quiz not found"
        )
    
    # Calculate score
    total_points = 0
    points_earned = 0
    detailed_answers = []
    
    for answer in submission.answers:
        question_data = mock_questions_db.get(answer.question_id)
        if not question_data:
            continue
        
        total_points += question_data["points"]
        is_correct = False
        
        # Check answer based on question type
        if question_data["question_type"] == QuestionType.MULTIPLE_CHOICE:
            correct_index = question_data["question_data"]["correct_answer_index"]
            is_correct = answer.answer == correct_index
        elif question_data["question_type"] == QuestionType.TRUE_FALSE:
            correct_answer = question_data["question_data"]["correct_answer"]
            is_correct = answer.answer == correct_answer
        elif question_data["question_type"] == QuestionType.FILL_IN_BLANK:
            correct_answers = question_data["question_data"]["correct_answers"]
            is_correct = str(answer.answer).lower().strip() in [ans.lower() for ans in correct_answers]
        
        if is_correct:
            points_earned += question_data["points"]
        
        detailed_answers.append({
            "question_id": answer.question_id,
            "user_answer": answer.answer,
            "is_correct": is_correct,
            "points_earned": question_data["points"] if is_correct else 0
        })
    
    # Calculate percentage score
    score_percentage = int((points_earned / total_points) * 100) if total_points > 0 else 0
    passed = score_percentage >= quiz_data["passing_score"]
    
    # Save result
    result_id = f"result_{len(mock_quiz_results_db) + 1}"
    result_key = f"{current_user.id}_{quiz_id}_{datetime.now().date()}"
    
    result_data = {
        "id": result_id,
        "user_id": current_user.id,
        "quiz_id": quiz_id,
        "score": score_percentage,
        "points_earned": points_earned,
        "total_points": total_points,
        "time_taken": submission.time_taken,
        "passed": passed,
        "submitted_at": datetime.now(),
        "answers": submission.answers
    }
    
    mock_quiz_results_db[result_key] = result_data
    
    # Get questions with answers for response
    questions_with_answers = []
    for question_data in mock_questions_db.values():
        if question_data["quiz_id"] == quiz_id:
            questions_with_answers.append(get_question_response(question_data, include_answers=True))
    
    return QuizResultResponse(
        id=result_id,
        quiz=QuizResponse(**quiz_data),
        score=score_percentage,
        points_earned=points_earned,
        total_points=total_points,
        time_taken=submission.time_taken,
        passed=passed,
        submitted_at=result_data["submitted_at"],
        questions_with_answers=questions_with_answers,
        user_answers=submission.answers
    )


@router.get("/history", response_model=List[QuizResultResponse])
async def get_quiz_history(
    current_user: UserResponse = Depends(get_current_user),
    limit: int = Query(10, ge=1, le=50)
):
    """Get user's quiz history"""
    user_results = []
    
    for result_data in mock_quiz_results_db.values():
        if result_data["user_id"] == current_user.id:
            quiz_data = mock_quizzes_db.get(result_data["quiz_id"])
            if quiz_data:
                # Get questions with answers
                questions_with_answers = []
                for question_data in mock_questions_db.values():
                    if question_data["quiz_id"] == result_data["quiz_id"]:
                        questions_with_answers.append(get_question_response(question_data, include_answers=True))
                
                user_results.append(QuizResultResponse(
                    id=result_data["id"],
                    quiz=QuizResponse(**quiz_data),
                    score=result_data["score"],
                    points_earned=result_data["points_earned"],
                    total_points=result_data["total_points"],
                    time_taken=result_data["time_taken"],
                    passed=result_data["passed"],
                    submitted_at=result_data["submitted_at"],
                    questions_with_answers=questions_with_answers,
                    user_answers=result_data["answers"]
                ))
    
    # Sort by submission date (newest first)
    user_results.sort(key=lambda x: x.submitted_at, reverse=True)
    
    return user_results[:limit]
