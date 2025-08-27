"""
Configuration settings for Comrade Backend
"""

import os
from typing import Optional
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    """Application settings"""
    
    # App settings
    app_name: str = "Comrade Backend"
    debug: bool = False
    
    # Database settings
    database_url: Optional[str] = None
    
    # Firebase settings
    firebase_credentials_path: Optional[str] = None
    firebase_project_id: Optional[str] = None
    
    # RSS Feed URLs
    pib_rss_url: str = "https://pib.gov.in/rss/leng.xml"
    hindu_rss_url: str = "https://www.thehindu.com/news/national/feeder/default.rss"
    indian_express_rss_url: str = "https://indianexpress.com/section/india/feed/"
    
    # JWT settings
    secret_key: str = "your-secret-key-change-in-production"
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30
    
    # CORS settings
    allowed_origins: list = ["*"]
    
    class Config:
        env_file = ".env"
        case_sensitive = False

# Global settings instance
settings = Settings()
