import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

/// Generic data state for handling loading, success, error, and idle states
@freezed
class DataState<T> with _$DataState<T> {
  const DataState._();

  /// Idle state - initial state before any operation
  const factory DataState.idle() = _Idle<T>;

  /// Loading state - operation in progress
  const factory DataState.loading() = _Loading<T>;

  /// Success state - operation completed successfully with data
  const factory DataState.success(T data) = _Success<T>;

  /// Error state - operation failed with error message
  const factory DataState.error([String? message]) = _Error<T>;

  // Helper getters for easy state checking
  bool get isIdle => this is _Idle<T>;
  bool get isLoading => this is _Loading<T>;
  bool get isSuccess => this is _Success<T>;
  bool get hasError => this is _Error<T>;

  // Get data if in success state, null otherwise
  T? get data => maybeWhen(
        success: (data) => data,
        orElse: () => null,
      );

  // Get error message if in error state, null otherwise
  String? get errorMessage => maybeWhen(
        error: (message) => message,
        orElse: () => null,
      );

  // Transform data if in success state
  DataState<R> transform<R>(R Function(T data) mapper) {
    return maybeWhen(
      success: (data) => DataState.success(mapper(data)),
      loading: () => const DataState.loading(),
      error: (message) => DataState.error(message),
      orElse: () => const DataState.idle(),
    );
  }

  // Handle different states with callbacks
  R handle<R>({
    required R Function() onIdle,
    required R Function() onLoading,
    required R Function(T data) onSuccess,
    required R Function(String? message) onError,
  }) {
    return when(
      idle: onIdle,
      loading: onLoading,
      success: onSuccess,
      error: onError,
    );
  }
}
