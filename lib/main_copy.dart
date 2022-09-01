// import 'package:flutter/material.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../router/router.gr.dart';
// import 'package:my_template/features/module_A/bloc/theme/theme_bloc.dart';
// import '../config/config_reader.dart';
// import '../config/environment.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// import '../localization/locale_constant.dart';
// import '../localization/localizations_delegate.dart';
// import 'package:my_template/features/module_A/screen/login/components/language_dropdown.dart';
// import 'localization/language/languages.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await ConfigReader.initializeApp(Environment.dev);
//   final AppRouter appRouter = AppRouter();
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => ThemeBloc(),
//         )
//       ],
//       child: MyApp(
//         appRouter: appRouter,
//       ),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final AppRouter _appRouter;

//   const MyApp({
//     Key? key,
//     required AppRouter appRouter,
//   })  : _appRouter = appRouter,
//         super(key: key);

//   @override
//   State<StatefulWidget> createState() => _MyAppState(appRouter: _appRouter);
// }

// class _MyAppState extends State<MyApp> {
//   late AppRouter appRouter;

//   _MyAppState({required this.appRouter});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routerDelegate: appRouter.delegate(),
//       routeInformationParser: appRouter.defaultRouteParser(),
//       builder: (context, router) => router!,
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   final String title = "sss";

//   static void setLocale(BuildContext context, Locale newLocale) {
//     var state = context.findAncestorStateOfType<_MyHomePageState>();
//     state!.setLocale(newLocale);
//   }

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   Locale _locale = const Locale("tc", "");

//   void setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   @override
//   void didChangeDependencies() async {
//     // determine which language to load on start up here
//     getLocale().then((locale) {
//       setState(() {
//         _locale = locale;
//       });
//     });
//     super.didChangeDependencies();
//   }

//   void _incrementCounter() {
//     print("XSSS1");
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(
//         builder: (context) => Center(
//           child: Column(
//             children: <Widget>[
//               RaisedButton(
//                 child: Text(Languages.of(context).appName),
//                 onPressed: () {
//                   AutoRouter.of(context).replaceNamed("/login");
//                 },
//               ),
//               LanguageDropDown(),
//             ],
//           ),
//         ),
//       ),
//       locale: _locale,
//       supportedLocales: const [
//         Locale('en', ''),
//         Locale('tc', ''),
//       ],
//       localizationsDelegates: const [
//         AppLocalizationsDelegate(),
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       localeResolutionCallback: (locale, supportedLocales) {
//         for (var supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale?.languageCode &&
//               supportedLocale.countryCode == locale?.countryCode) {
//             return supportedLocale;
//           }
//         }
//         return supportedLocales.first;
//       },
//     );
//   }
// }
