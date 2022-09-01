import 'my_localizations.dart';

/// The translations for English (`en`).
class MyLocalizationsEn extends MyLocalizations {
  MyLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Flutter Deer';

  @override
  String get verificationCodeLogin => 'Verification Code Login';

  @override
  String get passwordLogin => 'Password Login';

  @override
  String get login => 'Login';

  @override
  String get forgotPasswordLink => 'Forgot Password';

  @override
  String get inputPasswordHint => 'Please enter the password';

  @override
  String get inputUsernameHint => 'Please input username';

  @override
  String get noAccountRegisterLink => 'No account yet? Register now';

  @override
  String get register => 'Register';

  @override
  String get openYourAccount => 'Open your account';

  @override
  String get inputPhoneHint => 'Please enter phone number';

  @override
  String get inputVerificationCodeHint => 'Please enter verification code';

  @override
  String get inputPhoneInvalid => 'Please input valid mobile phone number';

  @override
  String get verificationButton => 'Not really sent, just log in!';

  @override
  String get getVerificationCode => 'Get verification code';

  @override
  String get confirm => 'Confirm';

  @override
  String get resetLoginPassword => 'Reset Login Password';

  @override
  String get registeredTips => 'Unregistered mobile phone number, please ';
}
