import 'l10n.dart';

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get title => 'Flutter Deer';

  @override
  String get verificationCodeLogin => '驗證碼登錄';

  @override
  String get passwordLogin => '密碼登錄';

  @override
  String get login => '登錄';

  @override
  String get forgotPasswordLink => '忘記密碼';

  @override
  String get inputPasswordHint => '請輸入密碼';

  @override
  String get inputUsernameHint => '請輸入賬號';

  @override
  String get noAccountRegisterLink => '還沒賬號？快去註冊';

  @override
  String get register => '註冊';

  @override
  String get openYourAccount => '開啟你的賬號';

  @override
  String get inputPhoneHint => '請輸入手機號';

  @override
  String get inputVerificationCodeHint => '請輸入驗證碼';

  @override
  String get inputPhoneInvalid => '請輸入有效的手機號';

  @override
  String get verificationButton => '並沒有真正發送哦，直接登錄吧！';

  @override
  String get getVerificationCode => '獲取驗證碼';

  @override
  String get confirm => '確認';

  @override
  String get resetLoginPassword => '重置登錄密碼';

  @override
  String get registeredTips => '提示：未註冊賬號的手機號，請先';
}
