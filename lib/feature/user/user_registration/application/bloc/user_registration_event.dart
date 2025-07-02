part of 'user_registration_bloc.dart';

enum RegistrationType{login, sign}

@freezed
class UserRegistrationEvent with _$UserRegistrationEvent {
  const factory UserRegistrationEvent.started() = _Started;
  const factory UserRegistrationEvent.resetState() = ResetState;
  const factory UserRegistrationEvent.registrationSelected({ required RegistrationType registrationType}) =RegistrationSelected;
  const factory UserRegistrationEvent.login({ required String email, required String password}) =Login;
  const factory UserRegistrationEvent.signUp({ required String email, required String password, required String username}) =SignUp;
}
