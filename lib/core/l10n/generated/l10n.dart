import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_zh.dart';

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// Title for the application
  ///
  /// In en, this message translates to:
  /// **'Flutter Deer'**
  String get title;

  /// Title for the Login page
  ///
  /// In en, this message translates to:
  /// **'Verification Code Login'**
  String get verificationCodeLogin;

  /// Password Login
  ///
  /// In en, this message translates to:
  /// **'Password Login'**
  String get passwordLogin;

  /// Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Forgot Password
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordLink;

  /// Please enter the password
  ///
  /// In en, this message translates to:
  /// **'Please enter the password'**
  String get inputPasswordHint;

  /// Please input username
  ///
  /// In en, this message translates to:
  /// **'Please input username'**
  String get inputUsernameHint;

  /// No account yet? Register now
  ///
  /// In en, this message translates to:
  /// **'No account yet? Register now'**
  String get noAccountRegisterLink;

  /// Register
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Open your account
  ///
  /// In en, this message translates to:
  /// **'Open your account'**
  String get openYourAccount;

  /// Please enter phone number
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get inputPhoneHint;

  /// Please enter verification code
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get inputVerificationCodeHint;

  /// Please input valid mobile phone number
  ///
  /// In en, this message translates to:
  /// **'Please input valid mobile phone number'**
  String get inputPhoneInvalid;

  /// Not really sent, just log in!
  ///
  /// In en, this message translates to:
  /// **'Not really sent, just log in!'**
  String get verificationButton;

  /// Get verification code
  ///
  /// In en, this message translates to:
  /// **'Get verification code'**
  String get getVerificationCode;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Reset login password
  ///
  /// In en, this message translates to:
  /// **'Reset Login Password'**
  String get resetLoginPassword;

  /// Registered Tips
  ///
  /// In en, this message translates to:
  /// **'Unregistered mobile phone number, please '**
  String get registeredTips;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'zh':
      return L10nZh();
  }

  throw FlutterError(
      'L10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
