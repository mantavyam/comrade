# Comrade - Defense Aspirants App

## Overview
Comrade is a pioneering mobile application designed exclusively for Indian defense aspirants preparing for the Services Selection Board (SSB) and related exams. This app serves as a comprehensive platform to enhance knowledge and motivation through daily news from verified sources, bookmarking features, quizzes based on read news, newspaper editorials, and inspirational "Stories of Guts and Glory" about military heroes. Built as a full-stack solution with Flutter (frontend) and Python (backend), it aims to be India's largest defense knowledge platform, starting with a Minimum Viable Product (MVP) focused on core features.

## Features

### Core Feature Set
- **Daily News**: Curated defense-related news with bookmarking and sharing
- **Interactive Quizzes**: Knowledge testing based on current affairs
- **Editorial Analysis**: In-depth commentary from leading newspapers  
- **Stories of Guts and Glory**: Inspirational military hero stories
- **Progress Tracking**: User engagement metrics and learning streaks

## Tech Stack
- **Frontend**: Flutter 3.8.1+ (cross-platform iOS/Android) with Clean Architecture (Domain-Application-Infrastructure layers)
- **Backend**: Python 3.10+ with FastAPI for REST APIs, feedparser for RSS, NLTK for quiz generation
- **Database**: Firebase Firestore (real-time user data) + Firebase Authentication
- **State Management**: Flutter BLoC/Cubit pattern with dependency injection (get_it)
- **UI/UX**: Custom dark theme with Urbanist font family, swipeable card interfaces
- **HTTP Client**: Dio for API communication with proper error handling
- **Testing**: bloc_test, mocktail for unit/widget testing
- **Code Generation**: Freezed for immutable models, json_serializable for JSON handling
- **Deployment**: Cloud hosting for backend, Google Play/App Store for mobile app

## Project Structure
```
comrade/
├── frontend/                    # Flutter frontend application
│   ├── android/                 # Android-specific configurations
│   ├── ios/                     # iOS-specific configurations  
│   ├── lib/
│   │   ├── main.dart            # App entry point with BLoC setup
│   │   ├── auth/                # Authentication feature module
│   │   ├── core/                # Shared utilities and constants
│   │   ├── home/                # Home screen with news feed
│   │   ├── news/                # News feature models
│   │   ├── editorials/          # Editorial content feature
│   │   ├── bookmarks/           # Bookmark management
│   │   ├── stories/             # Stories & Quiz feature
│   │   └── profile/             # User profile feature
│   ├── assets/                  # Static resources
│   ├── pubspec.yaml             # Flutter dependencies & configuration
│   ├── analysis_options.yaml    # Dart/Flutter linting rules
│   └── test/                    # Unit & widget tests
├── backend/                     # Python FastAPI backend
│   ├── main.py                  # FastAPI application entry point
│   ├── config.py                # Environment variables & settings
│   ├── requirements.txt         # Python dependencies
│   ├── .env.example             # Environment variables template
│   ├── routers/                 # API route handlers
│   │   ├── auth_router.py       # Authentication endpoints
│   │   ├── news_router.py       # News & RSS feed endpoints
│   │   └── quiz_router.py       # Quiz generation endpoints
│   └── models/                  # Pydantic data models
│       ├── user.py              # User model schemas
│       ├── news.py              # News item schemas
│       └── quiz.py              # Quiz question schemas
├── docs/                        # Documentation & design files
└── README.md                    # This file
```

## Installation & Setup

### Prerequisites
- Flutter SDK: Install from [flutter.dev](https://flutter.dev), run `flutter doctor`.
- Python 3.10+: With `pip` and `virtualenv`.
- Firebase: Project setup at [console.firebase.google.com](https://console.firebase.google.com), add iOS/Android apps.
- Git: For version control.

### Frontend Setup (Flutter)
1. **Prerequisites**: Install Flutter SDK 3.8.1+ from [flutter.dev](https://flutter.dev)
2. **Verify Installation**: Run `flutter doctor` to check setup
3. **Navigate to Frontend**: `cd frontend/`
4. **Install Dependencies**: `flutter pub get`
5. **Generate Code**: `flutter packages pub run build_runner build`
6. **Configure Firebase**: 
   - Add `google-services.json` to `android/app/` (Android)
   - Add `GoogleService-Info.plist` to `ios/Runner/` (iOS)
7. **Run Application**: `flutter run` (requires emulator or device)

### Backend Setup (Python)
1. **Prerequisites**: Python 3.10+ with pip
2. **Navigate to Backend**: `cd backend/`
3. **Create Virtual Environment**: `python -m venv env`
4. **Activate Environment**: 
   - macOS/Linux: `source env/bin/activate`
   - Windows: `env\Scripts\activate`
5. **Install Dependencies**: `pip install -r requirements.txt`
6. **Environment Setup**: 
   - Copy `.env.example` to `.env`
   - Configure Firebase credentials and API keys
7. **Run Server**: `uvicorn main:app --reload` (development mode)

### Development Environment
- **Recommended IDE**: VS Code with Flutter/Dart and Python extensions
- **Testing**: Run `flutter test` for frontend, `pytest` for backend
- **Linting**: Configured via `analysis_options.yaml` for Flutter

## Development Workflow

### Architecture Overview
- **Frontend**: Clean Architecture with feature-based modules (auth, home, stories, etc.)
- **State Management**: BLoC/Cubit pattern with dependency injection via get_it
- **Backend**: FastAPI with router-based API organization
- **Code Quality**: Automated code generation with Freezed, linting with analysis_options.yaml

### Git Workflow
- **Branches**: `main` (production), `development` (iteration and testing)
- **Development**: All work happens on `development` branch, features merged via PRs
- **Code Style**: Dart/Flutter linting enforced, Python follows PEP 8 standards

### Development Commands
```bash
# Frontend
flutter run                     # Run app in debug mode
flutter run --release          # Run optimized version
flutter pub get                 # Install dependencies
flutter packages pub run build_runner build  # Generate code
flutter test                    # Run tests
flutter analyze                 # Check code quality

# Backend  
uvicorn main:app --reload      # Run development server
pytest                         # Run tests
python -m pip install -r requirements.txt  # Install dependencies
```

## Contributing
- Fork the repo, create a feature branch, submit PRs to `develop`.
- Report issues via GitHub Issues.
- Follow the structure for new features.

## License
Creative Commons Attribution - NonCommercial license (CC BY-NC)

## Contact
For questions, reach out via GitHub Issues or my email.

## Emulator Running
```
flutter emulators --launch Pixel_9_Pro   
```