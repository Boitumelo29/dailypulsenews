import 'package:bloc/bloc.dart';
import 'package:dailypulsenews/core/utils/logger/logger.dart';
import 'package:dailypulsenews/feature/user/user_registration/domain/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repo;
  StreamSubscription<User?>? _authSubscription;

  AuthBloc(this.repo) : super(const AuthState()) {
    on<CheckAuthStatus>((event, emit) {
      emit(state.copyWith(status: AuthStatus.loading));

      try {
        final currentUser = repo.currentUser;
        if (currentUser != null) {
          emit(state.copyWith(
              status: AuthStatus.authenticated, user: currentUser));
        } else {
          emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
        }
      } catch (e) {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      }
    });

    on<SignOut>((event, emit) async {
      try {
        await repo.signOut();
        emit(state.copyWith(status: AuthStatus.logout));
      } catch (e) {
        emit(state.copyWith(status: AuthStatus.failure));
        logE(e);
      }
    });

    on<ListenToAuthChanges>((event, emit) {
      _authSubscription?.cancel();
      _authSubscription =
          FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        } else {
          emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
        }
      });
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
