import 'package:auto_route/auto_route.dart';
import 'package:my_template/features/module_A/screen/counter/counter_page.dart';
import 'package:my_template/features/module_A/screen/login/login_page.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    // AutoRoute( path: '/', page: MyHomePage, initial: true, ),
    AutoRoute(path: '/login', page: LoginPage),
    AutoRoute(path: '/counter', page: CounterPage),
  ],
)
class $AppRouter {}
