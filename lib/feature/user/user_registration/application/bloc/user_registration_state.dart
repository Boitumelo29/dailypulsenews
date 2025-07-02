part of 'user_registration_bloc.dart';

@freezed
abstract class UserRegistrationState with _$UserRegistrationState {
  factory UserRegistrationState({
    @Default(true) bool loginSelected,
    @Default(false) bool signUpSelected,
    @Default(false) bool isLoading,
    @Default(None()) Option<Either<Failure, Unit>>  loginEitherFailureOrUnit,
    @Default(None()) Option<Either<Failure, Unit>>  signupEitherFailureOrUnit,
    @Default(None()) Option<Either<Failure, Unit>>  logOutEitherFailureOrUnit,
  }) = _UserRegistrationState;
}
