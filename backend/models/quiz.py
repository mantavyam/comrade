"""
Quiz model for the Comrade backend
"""

from datetime import datetime
from typing import List, Optional, Dict, Any
from enum import Enum
from pydantic import BaseModel, Field


class QuestionType(str, Enum):
    """Question types"""
    MULTIPLE_CHOICE = "multiple_choice"
    TRUE_FALSE = "true_false"
    FILL_IN_BLANK = "fill_in_blank"


class DifficultyLevel(str, Enum):
    """Difficulty levels"""
    EASY = "easy"
    MEDIUM = "medium"
    HARD = "hard"


class QuestionBase(BaseModel):
    """Base question model"""
    question_text: str = Field(..., min_length=10, max_length=1000)
    question_type: QuestionType
    difficulty: DifficultyLevel = DifficultyLevel.MEDIUM
    explanation: Optional[str] = None
    tags: List[str] = Field(default_factory=list)
    points: int = Field(default=1, ge=1, le=10)


class MultipleChoiceQuestion(QuestionBase):
    """Multiple choice question model"""
    question_type: QuestionType = QuestionType.MULTIPLE_CHOICE
    options: List[str] = Field(..., min_items=2, max_items=6)
    correct_answer_index: int = Field(..., ge=0)


class TrueFalseQuestion(QuestionBase):
    """True/False question model"""
    question_type: QuestionType = QuestionType.TRUE_FALSE
    correct_answer: bool


class FillInBlankQuestion(QuestionBase):
    """Fill in the blank question model"""
    question_type: QuestionType = QuestionType.FILL_IN_BLANK
    correct_answers: List[str] = Field(..., min_items=1)  # Multiple acceptable answers


class QuestionCreate(BaseModel):
    """Question creation model"""
    question_text: str = Field(..., min_length=10, max_length=1000)
    question_type: QuestionType
    difficulty: DifficultyLevel = DifficultyLevel.MEDIUM
    explanation: Optional[str] = None
    tags: List[str] = Field(default_factory=list)
    points: int = Field(default=1, ge=1, le=10)
    # Question-specific data
    options: Optional[List[str]] = None  # For multiple choice
    correct_answer_index: Optional[int] = None  # For multiple choice
    correct_answer: Optional[bool] = None  # For true/false
    correct_answers: Optional[List[str]] = None  # For fill in blank


class Question(QuestionBase):
    """Complete question model"""
    id: str
    quiz_id: Optional[str] = None
    created_at: datetime
    updated_at: Optional[datetime] = None
    # Question-specific data stored as JSON
    question_data: Dict[str, Any]
    
    class Config:
        from_attributes = True


class QuestionResponse(BaseModel):
    """Question response model (without correct answers)"""
    id: str
    question_text: str
    question_type: str
    difficulty: str
    tags: List[str]
    points: int
    # Question-specific data (without correct answers for active quizzes)
    options: Optional[List[str]] = None  # For multiple choice


class QuestionWithAnswer(QuestionResponse):
    """Question response with correct answer (for results)"""
    explanation: Optional[str] = None
    correct_answer_index: Optional[int] = None  # For multiple choice
    correct_answer: Optional[bool] = None  # For true/false
    correct_answers: Optional[List[str]] = None  # For fill in blank


class QuizBase(BaseModel):
    """Base quiz model"""
    title: str = Field(..., min_length=5, max_length=200)
    description: Optional[str] = None
    time_limit: Optional[int] = None  # in minutes
    passing_score: int = Field(default=60, ge=0, le=100)  # percentage
    is_daily: bool = False
    is_active: bool = True
    tags: List[str] = Field(default_factory=list)


class QuizCreate(QuizBase):
    """Quiz creation model"""
    question_ids: List[str] = Field(..., min_items=1)


class QuizUpdate(BaseModel):
    """Quiz update model"""
    title: Optional[str] = Field(None, min_length=5, max_length=200)
    description: Optional[str] = None
    time_limit: Optional[int] = None
    passing_score: Optional[int] = Field(None, ge=0, le=100)
    is_active: Optional[bool] = None
    tags: Optional[List[str]] = None


class Quiz(QuizBase):
    """Complete quiz model"""
    id: str
    created_by: str  # user_id
    created_at: datetime
    updated_at: Optional[datetime] = None
    total_questions: int = 0
    total_points: int = 0
    
    class Config:
        from_attributes = True


class QuizResponse(BaseModel):
    """Quiz response model"""
    id: str
    title: str
    description: Optional[str] = None
    time_limit: Optional[int] = None
    passing_score: int
    is_daily: bool
    tags: List[str]
    total_questions: int
    total_points: int
    created_at: datetime


class QuizWithQuestions(QuizResponse):
    """Quiz with questions model"""
    questions: List[QuestionResponse]


class UserAnswer(BaseModel):
    """User answer model"""
    question_id: str
    answer: Any  # Can be int (for multiple choice), bool (for true/false), or str (for fill in blank)


class QuizSubmission(BaseModel):
    """Quiz submission model"""
    quiz_id: str
    answers: List[UserAnswer]
    time_taken: Optional[int] = None  # in seconds


class QuizResult(BaseModel):
    """Quiz result model"""
    id: str
    user_id: str
    quiz_id: str
    score: int  # percentage
    points_earned: int
    total_points: int
    time_taken: Optional[int] = None  # in seconds
    passed: bool
    submitted_at: datetime
    answers: List[Dict[str, Any]]  # Detailed answer breakdown
    
    class Config:
        from_attributes = True


class QuizResultResponse(BaseModel):
    """Quiz result response model"""
    id: str
    quiz: QuizResponse
    score: int
    points_earned: int
    total_points: int
    time_taken: Optional[int] = None
    passed: bool
    submitted_at: datetime
    questions_with_answers: List[QuestionWithAnswer]
    user_answers: List[UserAnswer]


class DailyQuizResponse(BaseModel):
    """Daily quiz response model"""
    date: datetime
    quiz: Optional[QuizWithQuestions] = None
    has_attempted: bool = False
    result: Optional[QuizResultResponse] = None
