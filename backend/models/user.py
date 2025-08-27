"""
User model for the Comrade backend
"""

from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel, EmailStr, Field


class UserBase(BaseModel):
    """Base user model with common fields"""
    name: str = Field(..., min_length=2, max_length=100)
    email: Optional[EmailStr] = None
    phone_number: Optional[str] = None
    is_email_verified: bool = False
    is_phone_verified: bool = False


class UserCreate(UserBase):
    """User creation model"""
    password: str = Field(..., min_length=6)


class UserUpdate(BaseModel):
    """User update model"""
    name: Optional[str] = Field(None, min_length=2, max_length=100)
    email: Optional[EmailStr] = None
    phone_number: Optional[str] = None
    profile_image_url: Optional[str] = None


class UserStats(BaseModel):
    """User statistics model"""
    current_streak: int = 0
    best_streak: int = 0
    quizzes_taken: int = 0
    minutes_practiced: int = 0
    weekly_streak: List[bool] = Field(default_factory=lambda: [False] * 7)


class User(UserBase):
    """Complete user model"""
    id: str
    profile_image_url: Optional[str] = None
    stats: UserStats = Field(default_factory=UserStats)
    created_at: datetime
    last_login_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True


class UserLogin(BaseModel):
    """User login model"""
    email: Optional[EmailStr] = None
    phone_number: Optional[str] = None
    password: str


class UserResponse(BaseModel):
    """User response model (without sensitive data)"""
    id: str
    name: str
    email: Optional[str] = None
    phone_number: Optional[str] = None
    profile_image_url: Optional[str] = None
    is_email_verified: bool = False
    is_phone_verified: bool = False
    stats: UserStats
    created_at: datetime
    last_login_at: Optional[datetime] = None


class Token(BaseModel):
    """JWT token model"""
    access_token: str
    token_type: str = "bearer"
    expires_in: int
    user: UserResponse


class TokenData(BaseModel):
    """Token data for JWT validation"""
    user_id: Optional[str] = None


class PasswordReset(BaseModel):
    """Password reset request model"""
    email: EmailStr


class PasswordResetConfirm(BaseModel):
    """Password reset confirmation model"""
    token: str
    new_password: str = Field(..., min_length=6)


class PhoneVerification(BaseModel):
    """Phone verification model"""
    phone_number: str
    verification_code: str


class EmailVerification(BaseModel):
    """Email verification model"""
    token: str
