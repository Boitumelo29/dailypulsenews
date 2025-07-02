import 'package:bloc/bloc.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/user/user_registration/domain/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_registration_event.dart';

part 'user_registration_state.dart';

part 'user_registration_bloc.freezed.dart';

class UserRegistrationBloc
    extends Bloc<UserRegistrationEvent, UserRegistrationState> {
  final IAuthRepository repo;

  UserRegistrationBloc(this.repo) : super(UserRegistrationState()) {
    on<ResetState>((event, emit) {
      emit(state.copyWith());
    });

    on<RegistrationSelected>((event, emit) {
      final isLogin = event.registrationType == RegistrationType.login;

      emit(state.copyWith(
        loginSelected: isLogin,
        signUpSelected: !isLogin,
      ));
    });

    on<Login>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await repo.signIn(email: event.email, password: event.password);
        emit(state.copyWith(isLoading:false, loginEitherFailureOrUnit: some(right(unit))));
      } catch (e) {
        emit(state.copyWith(
            isLoading: false,
            loginEitherFailureOrUnit:
                some(left(Failure(message: e.toString())))));
      }
    });

    on<SignUp>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await repo.signUp(email: event.email, password: event.password);
        emit(state.copyWith(isLoading:false, signupEitherFailureOrUnit: some(right(unit))));
      } catch (e) {
        emit(state.copyWith(
            isLoading:false,
            signupEitherFailureOrUnit:
                some(left(Failure(message: e.toString())))));
      }
    });
  }
}
