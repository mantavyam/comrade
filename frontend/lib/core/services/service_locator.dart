import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Auth services
import '../../auth/domain/i_auth_service.dart';
import '../../auth/infrastructure/mock_auth_service.dart';

// Services will be imported as we create them
// import '../services/api_service.dart';
// import '../services/storage_service.dart';

/// Global service locator instance
final GetIt getdep = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getdep.registerSingleton<SharedPreferences>(sharedPreferences);
  
  getdep.registerSingleton<http.Client>(http.Client());

  // Core services
  // getdep.registerSingleton<IApiService>(ApiService());
  // getdep.registerSingleton<IStorageService>(StorageService());

  // Auth service (using mock for now)
  getdep.registerSingleton<IAuthService>(MockAuthService());

  // Feature services will be registered here as we create them
  // News feature
  // getdep.registerSingleton<INewsService>(NewsService());
  
  // Quiz feature
  // getdep.registerSingleton<IQuizService>(QuizService());
  
  // Stories feature
  // getdep.registerSingleton<IStoriesService>(StoriesService());
  
  // Bookmark feature
  // getdep.registerSingleton<IBookmarkService>(BookmarkService());
  
  // User feature
  // getdep.registerSingleton<IUserService>(UserService());
}

/// Clean up dependencies
Future<void> disposeDependencies() async {
  await getdep.reset();
}
