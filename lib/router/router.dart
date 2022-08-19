import 'package:auto_route/auto_route.dart';
import '../main.dart';
import '../app/module_A/screen/counter/counter_page.dart';
import '../app/module_A/screen/login/login_page.dart';


// flutter pub run build_runner watch --delete-conflicting-outputs

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute( path: '/', page: MyHomePage, initial: true, ),
    AutoRoute( path: '/login', page: LoginPage),
    AutoRoute( path: '/counter', page: CounterPage),
  ],
)
class $AppRouter {}
