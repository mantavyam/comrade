"""
News router for the Comrade backend
"""

from datetime import datetime, timedelta
from typing import List, Optional
from fastapi import APIRouter, HTTPException, Depends, Query, status

from models.news import (
    News, NewsCreate, NewsUpdate, NewsResponse, NewsListResponse,
    NewsFilter, DailyNewsResponse, NewsCategory, NewsSource
)
from models.user import UserResponse
from routers.auth_router import get_current_user

router = APIRouter()

# Mock news database - replace with real database
mock_news_db = {}
mock_bookmarks_db = {}  # user_id -> set of news_ids

# Initialize with some mock news data
def initialize_mock_news():
    """Initialize mock news data"""
    mock_news = [
        {
            "id": "news_1",
            "title": "Indian Army Conducts Major Exercise Along LAC",
            "description": "The Indian Army conducted a comprehensive military exercise along the Line of Actual Control to test readiness and coordination.",
            "content": "In a significant display of military preparedness, the Indian Army conducted a major exercise along the Line of Actual Control (LAC) involving multiple divisions and advanced weaponry systems. The exercise, codenamed 'Operation Vigilance', tested the army's rapid deployment capabilities and inter-service coordination. Senior military officials stated that the exercise was part of routine preparedness drills and demonstrated India's commitment to defending its borders. The exercise involved over 10,000 personnel and included live-fire drills, tactical maneuvers, and coordination with air force units.",
            "image_url": "https://via.placeholder.com/400x280/2E7D32/FFFFFF?text=Defense+News",
            "source_url": "https://pib.gov.in/news/defense/exercise-lac",
            "source": NewsSource.PIB,
            "author": "Defense Correspondent",
            "category": NewsCategory.DEFENSE,
            "tags": ["Army", "LAC", "Exercise", "Defense"],
            "read_time": 3,
            "published_at": datetime.now() - timedelta(hours=2),
            "created_at": datetime.now() - timedelta(hours=2),
            "updated_at": None,
            "is_featured": True,
            "view_count": 1250
        },
        {
            "id": "news_2",
            "title": "New Defense Technology Initiative Launched",
            "description": "Government announces new initiative to boost indigenous defense technology development and reduce import dependency.",
            "content": "The Ministry of Defense today announced a groundbreaking initiative aimed at accelerating indigenous defense technology development. The 'Atmanirbhar Defense Technology Mission' will allocate ₹50,000 crores over the next five years to support research and development in critical defense technologies. The initiative focuses on artificial intelligence, cyber security, advanced materials, and autonomous systems. Defense Minister emphasized that this program will significantly reduce India's dependence on defense imports and create thousands of high-tech jobs.",
            "image_url": "https://via.placeholder.com/400x280/FF9800/FFFFFF?text=Technology",
            "source_url": "https://thehindu.com/news/defense-technology-initiative",
            "source": NewsSource.HINDU,
            "author": "Tech Reporter",
            "category": NewsCategory.TECHNOLOGY,
            "tags": ["Technology", "Defense", "Innovation", "Make in India"],
            "read_time": 4,
            "published_at": datetime.now() - timedelta(hours=4),
            "created_at": datetime.now() - timedelta(hours=4),
            "updated_at": None,
            "is_featured": False,
            "view_count": 890
        },
        {
            "id": "news_3",
            "title": "International Military Cooperation Summit",
            "description": "India hosts international summit on military cooperation and peacekeeping operations with allied nations.",
            "content": "New Delhi hosted a significant international summit focusing on military cooperation and joint peacekeeping operations. Representatives from 25 countries participated in the three-day summit, discussing regional security challenges and collaborative defense strategies. The summit resulted in several bilateral agreements for joint training programs and technology sharing initiatives. Prime Minister highlighted India's growing role in global peacekeeping and its commitment to international security cooperation.",
            "image_url": "https://via.placeholder.com/400x280/2196F3/FFFFFF?text=International",
            "source_url": "https://indianexpress.com/news/international-military-summit",
            "source": NewsSource.INDIAN_EXPRESS,
            "author": "International Desk",
            "category": NewsCategory.INTERNATIONAL,
            "tags": ["International", "Cooperation", "Summit", "Peacekeeping"],
            "read_time": 5,
            "published_at": datetime.now() - timedelta(hours=6),
            "created_at": datetime.now() - timedelta(hours=6),
            "updated_at": None,
            "is_featured": True,
            "view_count": 2100
        },
        {
            "id": "news_4",
            "title": "Defense Budget Allocation Increased",
            "description": "Government announces significant increase in defense budget allocation for modernization and infrastructure development.",
            "content": "The government has announced a substantial increase in defense budget allocation, focusing on modernization of armed forces and infrastructure development. The defense budget for the current fiscal year has been increased by 15% compared to the previous year, with special emphasis on indigenous procurement and technology development. The allocation includes funds for new aircraft, naval vessels, and advanced communication systems. Finance Minister stated that this investment reflects the government's commitment to national security and self-reliance in defense.",
            "image_url": "https://via.placeholder.com/400x280/4CAF50/FFFFFF?text=Budget",
            "source_url": "https://pib.gov.in/news/defense-budget-increase",
            "source": NewsSource.PIB,
            "author": "Economic Reporter",
            "category": NewsCategory.ECONOMY,
            "tags": ["Budget", "Defense", "Modernization", "Infrastructure"],
            "read_time": 3,
            "published_at": datetime.now() - timedelta(hours=8),
            "created_at": datetime.now() - timedelta(hours=8),
            "updated_at": None,
            "is_featured": False,
            "view_count": 1560
        }
    ]
    
    for news in mock_news:
        mock_news_db[news["id"]] = news

# Initialize mock data
initialize_mock_news()


def get_news_response(news_data: dict, user_id: Optional[str] = None) -> NewsResponse:
    """Convert news data to NewsResponse with bookmark status"""
    is_bookmarked = False
    if user_id:
        user_bookmarks = mock_bookmarks_db.get(user_id, set())
        is_bookmarked = news_data["id"] in user_bookmarks
    
    return NewsResponse(
        **news_data,
        is_bookmarked=is_bookmarked
    )


@router.get("/daily", response_model=DailyNewsResponse)
async def get_daily_news(
    date: Optional[str] = Query(None, description="Date in YYYY-MM-DD format"),
    current_user: Optional[UserResponse] = Depends(get_current_user)
):
    """Get daily news for a specific date"""
    target_date = datetime.now().date()
    if date:
        try:
            target_date = datetime.strptime(date, "%Y-%m-%d").date()
        except ValueError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid date format. Use YYYY-MM-DD"
            )
    
    # Filter news for the target date
    daily_news = []
    categories_count = {}
    
    for news_data in mock_news_db.values():
        news_date = news_data["published_at"].date()
        if news_date == target_date:
            news_response = get_news_response(
                news_data, 
                current_user.id if current_user else None
            )
            daily_news.append(news_response)
            
            # Count categories
            category = news_data["category"]
            categories_count[category] = categories_count.get(category, 0) + 1
    
    # Sort by published time (newest first)
    daily_news.sort(key=lambda x: x.published_at, reverse=True)
    
    return DailyNewsResponse(
        date=datetime.combine(target_date, datetime.min.time()),
        news=daily_news,
        total_count=len(daily_news),
        categories_count=categories_count
    )


@router.get("/", response_model=NewsListResponse)
async def get_news(
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=50),
    category: Optional[NewsCategory] = None,
    source: Optional[NewsSource] = None,
    search: Optional[str] = None,
    featured_only: bool = False,
    current_user: Optional[UserResponse] = Depends(get_current_user)
):
    """Get news with pagination and filters"""
    # Filter news
    filtered_news = []
    
    for news_data in mock_news_db.values():
        # Apply filters
        if category and news_data["category"] != category:
            continue
        if source and news_data["source"] != source:
            continue
        if featured_only and not news_data["is_featured"]:
            continue
        if search:
            search_lower = search.lower()
            if (search_lower not in news_data["title"].lower() and 
                search_lower not in news_data["description"].lower()):
                continue
        
        filtered_news.append(news_data)
    
    # Sort by published time (newest first)
    filtered_news.sort(key=lambda x: x["published_at"], reverse=True)
    
    # Pagination
    total = len(filtered_news)
    start_idx = (page - 1) * per_page
    end_idx = start_idx + per_page
    paginated_news = filtered_news[start_idx:end_idx]
    
    # Convert to response format
    news_responses = [
        get_news_response(news_data, current_user.id if current_user else None)
        for news_data in paginated_news
    ]
    
    return NewsListResponse(
        news=news_responses,
        total=total,
        page=page,
        per_page=per_page,
        has_next=end_idx < total,
        has_prev=page > 1
    )


@router.get("/{news_id}", response_model=NewsResponse)
async def get_news_by_id(
    news_id: str,
    current_user: Optional[UserResponse] = Depends(get_current_user)
):
    """Get news by ID"""
    news_data = mock_news_db.get(news_id)
    if not news_data:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="News not found"
        )
    
    # Increment view count
    news_data["view_count"] += 1
    
    return get_news_response(news_data, current_user.id if current_user else None)


@router.get("/category/{category}", response_model=NewsListResponse)
async def get_news_by_category(
    category: NewsCategory,
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=50),
    current_user: Optional[UserResponse] = Depends(get_current_user)
):
    """Get news by category"""
    return await get_news(
        page=page,
        per_page=per_page,
        category=category,
        current_user=current_user
    )


@router.get("/trending", response_model=List[NewsResponse])
async def get_trending_news(
    limit: int = Query(10, ge=1, le=20),
    current_user: Optional[UserResponse] = Depends(get_current_user)
):
    """Get trending news based on view count"""
    # Sort by view count (highest first)
    trending_news = sorted(
        mock_news_db.values(),
        key=lambda x: x["view_count"],
        reverse=True
    )[:limit]
    
    return [
        get_news_response(news_data, current_user.id if current_user else None)
        for news_data in trending_news
    ]
