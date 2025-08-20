/// API endpoint constants for backend communication
class KApiEndpoints {
  KApiEndpoints._();

  // Base URLs
  static const String baseUrl = 'http://localhost:8000'; // Development
  static const String apiVersion = '/api/v1';
  static const String baseApiUrl = baseUrl + apiVersion;

  // Authentication Endpoints
  static const String auth = '$baseApiUrl/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String logout = '$auth/logout';
  static const String refreshToken = '$auth/refresh';
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';
  static const String verifyOTP = '$auth/verify-otp';
  static const String resendOTP = '$auth/resend-otp';

  // News Endpoints
  static const String news = '$baseApiUrl/news';
  static const String dailyNews = '$news/daily';
  static const String newsById = '$news/{id}';
  static const String newsByCategory = '$news/category/{category}';
  static const String newsSearch = '$news/search';
  static const String trendingNews = '$news/trending';

  // Editorial Endpoints
  static const String editorials = '$baseApiUrl/editorials';
  static const String dailyEditorials = '$editorials/daily';
  static const String editorialById = '$editorials/{id}';
  static const String editorialsBySource = '$editorials/source/{source}';

  // Quiz Endpoints
  static const String quiz = '$baseApiUrl/quiz';
  static const String dailyQuiz = '$quiz/daily';
  static const String quizById = '$quiz/{id}';
  static const String submitQuiz = '$quiz/{id}/submit';
  static const String quizResults = '$quiz/{id}/results';
  static const String quizHistory = '$quiz/history';
  static const String generateQuiz = '$quiz/generate';

  // Stories Endpoints
  static const String stories = '$baseApiUrl/stories';
  static const String heroStories = '$stories/heroes';
  static const String storyById = '$stories/{id}';
  static const String storiesByCategory = '$stories/category/{category}';
  static const String featuredStories = '$stories/featured';

  // User Endpoints
  static const String user = '$baseApiUrl/user';
  static const String userProfile = '$user/profile';
  static const String updateProfile = '$user/profile';
  static const String userStats = '$user/stats';
  static const String userStreaks = '$user/streaks';
  static const String updateStreak = '$user/streaks';

  // Bookmark Endpoints
  static const String bookmarks = '$baseApiUrl/bookmarks';
  static const String addBookmark = bookmarks;
  static const String removeBookmark = '$bookmarks/{id}';
  static const String bookmarkCategories = '$bookmarks/categories';
  static const String createCategory = '$bookmarks/categories';
  static const String bookmarksByCategory = '$bookmarks/category/{categoryId}';

  // Notification Endpoints
  static const String notifications = '$baseApiUrl/notifications';
  static const String markAsRead = '$notifications/{id}/read';
  static const String markAllAsRead = '$notifications/read-all';
  static const String notificationSettings = '$notifications/settings';

  // Content Sharing Endpoints
  static const String share = '$baseApiUrl/share';
  static const String shareNews = '$share/news/{id}';
  static const String shareEditorial = '$share/editorial/{id}';
  static const String shareStory = '$share/story/{id}';

  // Analytics Endpoints
  static const String analytics = '$baseApiUrl/analytics';
  static const String trackEvent = '$analytics/event';
  static const String trackPageView = '$analytics/page-view';
  static const String trackQuizAttempt = '$analytics/quiz-attempt';

  // Health Check
  static const String health = '$baseUrl/health';
  static const String version = '$baseUrl/version';

  // Helper methods for dynamic endpoints
  static String getNewsById(String id) => newsById.replaceAll('{id}', id);
  static String getNewsByCategory(String category) => newsByCategory.replaceAll('{category}', category);
  static String getEditorialById(String id) => editorialById.replaceAll('{id}', id);
  static String getEditorialsBySource(String source) => editorialsBySource.replaceAll('{source}', source);
  static String getQuizById(String id) => quizById.replaceAll('{id}', id);
  static String getSubmitQuiz(String id) => submitQuiz.replaceAll('{id}', id);
  static String getQuizResults(String id) => quizResults.replaceAll('{id}', id);
  static String getStoryById(String id) => storyById.replaceAll('{id}', id);
  static String getStoriesByCategory(String category) => storiesByCategory.replaceAll('{category}', category);
  static String getRemoveBookmark(String id) => removeBookmark.replaceAll('{id}', id);
  static String getBookmarksByCategory(String categoryId) => bookmarksByCategory.replaceAll('{categoryId}', categoryId);
  static String getMarkAsRead(String id) => markAsRead.replaceAll('{id}', id);
  static String getShareNews(String id) => shareNews.replaceAll('{id}', id);
  static String getShareEditorial(String id) => shareEditorial.replaceAll('{id}', id);
  static String getShareStory(String id) => shareStory.replaceAll('{id}', id);
}
