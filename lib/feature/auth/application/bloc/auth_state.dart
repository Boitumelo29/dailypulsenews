part of 'auth_bloc.dart';

enum AuthStatus { initial, authenticated, unauthenticated, failure, loading, logout }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    User? user,
    String? error
  }) = _AuthState;

}