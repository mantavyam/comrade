# Comrade - Defense Aspirants App

## Overview
Comrade is a pioneering mobile application designed exclusively for Indian defense aspirants preparing for the Services Selection Board (SSB) and related exams. This app serves as a comprehensive platform to enhance knowledge and motivation through daily news from verified sources (e.g., PIB, The Hindu, Indian Express), bookmarking features, quizzes based on read news, newspaper editorials, and inspirational "Stories of Guts and Glory" about military heroes. Built as a full-stack solution with Flutter (frontend) and Python (backend), it aims to be India's largest defense knowledge platform, starting with a Minimum Viable Product (MVP) focused on core features.

## Features
- **Daily News**: Curated from official RSS feeds (e.g., PIB, The Hindu) with bookmarking and sharing options.
- **Quizzes**: Text-based quizzes generated from news to test comprehension.
- **Editorials**: In-depth analysis from leading newspapers.
- **Stories of Guts and Glory**: Inspirational tales of Indian armed forces heroes.
- **User Profile**: Track streaks, practice stats, and manage account settings.
- **Auth Flows**: Login/Signup with Google/Phone, forget password recovery, guest mode.

## Tech Stack
- **Frontend**: Flutter 3.x (cross-platform iOS/Android) with Firebase integration.
- **Backend**: Python with FastAPI for REST APIs, feedparser for RSS, NLTK for quiz generation.
- **Database**: Firebase Firestore (real-time user data), optional SQLite for local caching.
- **Auth**: Firebase Authentication (Google, Phone OTP).
- **Dependencies**: Managed via `pubspec.yaml` (Flutter) and `requirements.txt` (Python).
- **Deployment**: Heroku/AWS for backend, Google Play/App Store for app.

## Project Structure
```
comrade-app/
├── frontend/                # Flutter frontend
│   ├── android/             # Android configs
│   ├── ios/                 # iOS configs
│   ├── lib/
│   │   ├── main.dart        # App entry
│   │   ├── routes.dart      # Navigation
│   │   ├── constants/       # Global constants (colors, strings, APIs)
│   │   ├── models/          # Data models (NewsItem, UserProfile)
│   │   ├── services/        # API/Firestore logic
│   │   ├── providers/       # State management
│   │   ├── screens/         # Feature screens (auth, news, etc.)
│   │   └── widgets/         # Reusable UI components
│   ├── assets/              # Images, GIFs, fonts
│   ├── pubspec.yaml         # Flutter dependencies
│   └── test/                # Tests
├── backend/                 # Python backend
│   ├── main.py              # FastAPI entry
│   ├── requirements.txt     # Python dependencies
│   ├── routers/             # API endpoints (news, quiz, etc.)
│   ├── models/              # Pydantic schemas
│   ├── utils/               # Helper functions (RSS, quiz)
│   ├── config.py            # Env vars
│   ├── schemas/             # DB schemas (if SQLite)
│   └── tests/               # API tests
├── docs/                    # Figma files, user flows (Mermaid), API specs
├── .env                     # Secrets (Firebase keys)
├── .gitignore               # Ignore build artifacts
├── docker-compose.yml       # Optional local dev setup
└── README.md                # This file
```

## Installation & Setup

### Prerequisites
- Flutter SDK: Install from [flutter.dev](https://flutter.dev), run `flutter doctor`.
- Python 3.10+: With `pip` and `virtualenv`.
- Firebase: Project setup at [console.firebase.google.com](https://console.firebase.google.com), add iOS/Android apps.
- Git: For version control.

### Frontend Setup
1. Navigate to `frontend/`.
2. Run `flutter pub get` to install dependencies.
3. Configure Firebase: Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from Firebase.
4. Run the app: `flutter run` (emulator or device).

### Backend Setup
1. Navigate to `backend/`.
2. Create virtual env: `python -m venv env`.
3. Activate env: `source env/bin/activate` (Linux/Mac) or `env\Scripts\activate` (Windows).
4. Install dependencies: `pip install -r requirements.txt`.
5. Set env vars: Create `.env` with Firebase credentials and API keys.
6. Run server: `uvicorn main:app --reload`.
7. Schedule RSS fetch: Configure APScheduler in `main.py`.

### Testing
- Frontend: `flutter test` for unit tests; manual testing on devices.
- Backend: Use `pytest` in `backend/tests/`.

## Development Workflow
- **Version Control**: Use Git with branches: `main` (stable), `develop` (WIP), feature branches (e.g., `feature/auth-flow`).
- **Code Style**: Prettier/ESLint for Flutter; follow PEP 8 for Python.
- **Build Cycle**: Hot reload with `flutter run -d <device>`; debug with VS Code breakpoints.
- **Deployment**: Backend to Heroku (`git push heroku main`); Flutter to TestFlight/Google Play Beta.

## Roadmap
1. **Setup Phase**: Initialize repo, configure Flutter/Python/Firestore, launch splash screen.
2. **Auth Implementation**: Build login/signup/forget password flows.
3. **Core Features**: Develop news and bookmark screens with swipeable UI.
4. **MVP Completion**: Add editorials, quizzes, stories, and profile.
5. **Polish & Deploy**: Add animations, analytics, deploy to beta.
6. **Post-MVP**: Gather feedback, expand with vocab, SSB magazine, GTO simulator.

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