part of 'user_registration_bloc.dart';

@freezed
abstract class UserRegistrationState with _$UserRegistrationState {
  factory UserRegistrationState({
    @Default(true) bool loginSelected,
    @Default(false) bool signUpSelected,
    @Default(None()) Option<Either<Failure, Unit>>  loginEitherFailureOrUnit,
    @Default(None()) Option<Either<Failure, Unit>>  signupEitherFailureOrUnit,
  }) = _UserRegistrationState;
}
