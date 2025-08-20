"""
Comrade Backend - FastAPI Application
Defense Aspirants App Backend
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
import uvicorn
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Import routers
from routers import auth_router, news_router, quiz_router

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan events"""
    # Startup
    print("🚀 Comrade Backend starting up...")
    
    # Initialize services here
    # - Firebase Admin SDK
    # - RSS feed scheduler
    # - NLTK data download
    
    yield
    
    # Shutdown
    print("🛑 Comrade Backend shutting down...")

# Create FastAPI app
app = FastAPI(
    title="Comrade API",
    description="Backend API for Comrade - Defense Aspirants App",
    version="1.0.0",
    lifespan=lifespan
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure properly for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth_router.router, prefix="/api/v1/auth", tags=["auth"])
app.include_router(news_router.router, prefix="/api/v1/news", tags=["news"])
app.include_router(quiz_router.router, prefix="/api/v1/quiz", tags=["quiz"])

@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "Welcome to Comrade API",
        "version": "1.0.0",
        "status": "active"
    }

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy", "service": "comrade-backend"}

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True
    )
