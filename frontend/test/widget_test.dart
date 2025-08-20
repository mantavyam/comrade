// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:comrade/auth/infrastructure/mock_auth_service.dart';
import 'package:comrade/auth/domain/auth_error.dart';

void main() {
  group('MockAuthService Tests', () {
    late MockAuthService authService;

    setUp(() {
      authService = MockAuthService();
    });

    tearDown(() {
      authService.dispose();
    });

    test('should validate email correctly', () {
      expect(authService.isValidEmail('test@example.com'), isTrue);
      expect(authService.isValidEmail('invalid-email'), isFalse);
      expect(authService.isValidEmail(''), isFalse);
    });

    test('should validate password correctly', () {
      expect(authService.isValidPassword('123456'), isTrue);
      expect(authService.isValidPassword('12345'), isFalse);
      expect(authService.isValidPassword(''), isFalse);
    });

    test('should validate name correctly', () {
      expect(authService.isValidName('John Doe'), isTrue);
      expect(authService.isValidName('A'), isFalse);
      expect(authService.isValidName(''), isFalse);
    });

    test('should sign in with valid credentials', () async {
      final result = await authService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: '123456',
      );

      expect(result.isSuccess, isTrue);
      expect(result.success.email, equals('test@example.com'));
      expect(authService.isAuthenticated, isTrue);
    });

    test('should fail sign in with invalid email', () async {
      final result = await authService.signInWithEmailAndPassword(
        email: 'invalid-email',
        password: '123456',
      );

      expect(result.isFailure, isTrue);
      expect(result.failure, equals(AuthError.invalidEmail));
    });

    test('should fail sign in with weak password', () async {
      final result = await authService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: '123',
      );

      expect(result.isFailure, isTrue);
      expect(result.failure, equals(AuthError.weakPassword));
    });
  });
}
