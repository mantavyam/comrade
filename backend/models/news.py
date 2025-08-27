"""
News model for the Comrade backend
"""

from datetime import datetime
from typing import List, Optional
from enum import Enum
from pydantic import BaseModel, Field, HttpUrl


class NewsCategory(str, Enum):
    """News categories"""
    GENERAL = "general"
    DEFENSE = "defense"
    POLITICS = "politics"
    INTERNATIONAL = "international"
    ECONOMY = "economy"
    TECHNOLOGY = "technology"
    SPORTS = "sports"
    EDITORIAL = "editorial"


class NewsSource(str, Enum):
    """News sources"""
    PIB = "Press Information Bureau"
    HINDU = "The Hindu"
    INDIAN_EXPRESS = "Indian Express"
    TIMES_OF_INDIA = "Times of India"
    HINDUSTAN_TIMES = "Hindustan Times"
    ECONOMIC_TIMES = "Economic Times"


class NewsBase(BaseModel):
    """Base news model"""
    title: str = Field(..., min_length=10, max_length=500)
    description: str = Field(..., min_length=20, max_length=1000)
    content: str = Field(..., min_length=50)
    image_url: Optional[HttpUrl] = None
    source_url: HttpUrl
    source: NewsSource
    author: Optional[str] = None
    category: NewsCategory = NewsCategory.GENERAL
    tags: List[str] = Field(default_factory=list)
    read_time: int = Field(default=3, ge=1, le=60)  # in minutes


class NewsCreate(NewsBase):
    """News creation model"""
    pass


class NewsUpdate(BaseModel):
    """News update model"""
    title: Optional[str] = Field(None, min_length=10, max_length=500)
    description: Optional[str] = Field(None, min_length=20, max_length=1000)
    content: Optional[str] = Field(None, min_length=50)
    image_url: Optional[HttpUrl] = None
    category: Optional[NewsCategory] = None
    tags: Optional[List[str]] = None
    read_time: Optional[int] = Field(None, ge=1, le=60)


class News(NewsBase):
    """Complete news model"""
    id: str
    published_at: datetime
    created_at: datetime
    updated_at: Optional[datetime] = None
    is_featured: bool = False
    view_count: int = 0
    
    class Config:
        from_attributes = True


class NewsResponse(BaseModel):
    """News response model"""
    id: str
    title: str
    description: str
    content: str
    image_url: Optional[str] = None
    source_url: str
    source: str
    author: Optional[str] = None
    category: str
    tags: List[str]
    read_time: int
    published_at: datetime
    created_at: datetime
    is_featured: bool = False
    view_count: int = 0
    is_bookmarked: bool = False  # Will be set based on user context


class NewsListResponse(BaseModel):
    """News list response model"""
    news: List[NewsResponse]
    total: int
    page: int
    per_page: int
    has_next: bool
    has_prev: bool


class NewsFilter(BaseModel):
    """News filter model"""
    category: Optional[NewsCategory] = None
    source: Optional[NewsSource] = None
    tags: Optional[List[str]] = None
    date_from: Optional[datetime] = None
    date_to: Optional[datetime] = None
    search: Optional[str] = None
    featured_only: bool = False


class DailyNewsResponse(BaseModel):
    """Daily news response model"""
    date: datetime
    news: List[NewsResponse]
    total_count: int
    categories_count: dict  # category -> count mapping
