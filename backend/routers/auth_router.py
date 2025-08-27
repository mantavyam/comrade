"""
Authentication router for the Comrade backend
"""

from datetime import datetime, timedelta
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from pydantic import BaseModel

from models.user import (
    User, UserCreate, UserLogin, UserResponse, Token,
    PasswordReset, PasswordResetConfirm, PhoneVerification
)

router = APIRouter()
security = HTTPBearer()

# Mock user database - replace with real database
mock_users_db = {}
mock_tokens_db = {}


class AuthService:
    """Mock authentication service"""
    
    @staticmethod
    def hash_password(password: str) -> str:
        """Hash password - replace with real hashing"""
        return f"hashed_{password}"
    
    @staticmethod
    def verify_password(plain_password: str, hashed_password: str) -> bool:
        """Verify password - replace with real verification"""
        return f"hashed_{plain_password}" == hashed_password
    
    @staticmethod
    def create_access_token(user_id: str) -> str:
        """Create JWT token - replace with real JWT"""
        token = f"token_{user_id}_{datetime.now().timestamp()}"
        mock_tokens_db[token] = {
            "user_id": user_id,
            "expires_at": datetime.now() + timedelta(hours=24)
        }
        return token
    
    @staticmethod
    def verify_token(token: str) -> Optional[str]:
        """Verify JWT token - replace with real JWT verification"""
        token_data = mock_tokens_db.get(token)
        if not token_data:
            return None
        
        if datetime.now() > token_data["expires_at"]:
            del mock_tokens_db[token]
            return None
        
        return token_data["user_id"]


def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)) -> UserResponse:
    """Get current authenticated user"""
    token = credentials.credentials
    user_id = AuthService.verify_token(token)
    
    if not user_id:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired token",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    user = mock_users_db.get(user_id)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not found",
        )
    
    return UserResponse(**user)


@router.post("/register", response_model=Token)
async def register(user_data: UserCreate):
    """Register a new user"""
    # Check if user already exists
    for user in mock_users_db.values():
        if user.get("email") == user_data.email:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email already registered"
            )
    
    # Create new user
    user_id = f"user_{len(mock_users_db) + 1}"
    new_user = {
        "id": user_id,
        "name": user_data.name,
        "email": user_data.email,
        "phone_number": user_data.phone_number,
        "password": AuthService.hash_password(user_data.password),
        "is_email_verified": False,
        "is_phone_verified": False,
        "profile_image_url": None,
        "stats": {
            "current_streak": 0,
            "best_streak": 0,
            "quizzes_taken": 0,
            "minutes_practiced": 0,
            "weekly_streak": [False] * 7
        },
        "created_at": datetime.now(),
        "last_login_at": None
    }
    
    mock_users_db[user_id] = new_user
    
    # Create access token
    access_token = AuthService.create_access_token(user_id)
    
    # Update last login
    new_user["last_login_at"] = datetime.now()
    
    return Token(
        access_token=access_token,
        token_type="bearer",
        expires_in=86400,  # 24 hours
        user=UserResponse(**new_user)
    )


@router.post("/login", response_model=Token)
async def login(user_data: UserLogin):
    """Login user"""
    # Find user by email or phone
    user = None
    user_id = None
    
    for uid, u in mock_users_db.items():
        if (user_data.email and u.get("email") == user_data.email) or \
           (user_data.phone_number and u.get("phone_number") == user_data.phone_number):
            user = u
            user_id = uid
            break
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid credentials"
        )
    
    # Verify password
    if not AuthService.verify_password(user_data.password, user["password"]):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid credentials"
        )
    
    # Create access token
    access_token = AuthService.create_access_token(user_id)
    
    # Update last login
    user["last_login_at"] = datetime.now()
    
    return Token(
        access_token=access_token,
        token_type="bearer",
        expires_in=86400,  # 24 hours
        user=UserResponse(**user)
    )


@router.post("/logout")
async def logout(current_user: UserResponse = Depends(get_current_user)):
    """Logout user"""
    # In a real implementation, you would invalidate the token
    return {"message": "Successfully logged out"}


@router.get("/me", response_model=UserResponse)
async def get_current_user_info(current_user: UserResponse = Depends(get_current_user)):
    """Get current user information"""
    return current_user


@router.post("/forgot-password")
async def forgot_password(data: PasswordReset):
    """Send password reset email"""
    # Find user by email
    user = None
    for u in mock_users_db.values():
        if u.get("email") == data.email:
            user = u
            break
    
    if not user:
        # Don't reveal if email exists or not
        return {"message": "If the email exists, a reset link has been sent"}
    
    # In a real implementation, send email with reset token
    return {"message": "If the email exists, a reset link has been sent"}


@router.post("/reset-password")
async def reset_password(data: PasswordResetConfirm):
    """Reset password with token"""
    # In a real implementation, verify the reset token
    # For now, just return success
    return {"message": "Password reset successfully"}


@router.post("/verify-phone")
async def verify_phone(data: PhoneVerification):
    """Verify phone number with OTP"""
    # In a real implementation, verify the OTP
    # For now, just return success
    return {"message": "Phone number verified successfully"}


@router.post("/resend-otp")
async def resend_otp(phone_number: str):
    """Resend OTP for phone verification"""
    # In a real implementation, send new OTP
    return {"message": "OTP sent successfully"}


@router.post("/refresh", response_model=Token)
async def refresh_token(current_user: UserResponse = Depends(get_current_user)):
    """Refresh access token"""
    # Create new access token
    access_token = AuthService.create_access_token(current_user.id)
    
    return Token(
        access_token=access_token,
        token_type="bearer",
        expires_in=86400,  # 24 hours
        user=current_user
    )
