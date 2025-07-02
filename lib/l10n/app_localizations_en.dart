import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dailyPulseNews => 'Daily Pulse News';

  @override
  String get noNewNews => 'No New News';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String get username => 'Username';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get logout => 'logout';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get selectCountry => 'Select a Country';

  @override
  String trending(Object date) {
    return 'Trending • $date';
  }

  @override
  String get noContent => 'No content available';

  @override
  String get loginError => 'Unable to Login.';

  @override
  String get signUpError => 'Unable to Sign Up.';
}
