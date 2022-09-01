import 'package:fluro/fluro.dart';
import 'package:my_template/core/home/home_page.dart';
import 'package:my_template/core/routers/i_router.dart';
import 'package:my_template/features/module_A/screen/home_page/second_page.dart';
import 'package:my_template/features/module_A/screen/home_page/sign_in_screen.dart';

class TodoRouter implements IRouterProvider {
  static String accountPage = '/account';
  static String homePage = '/home';
  static String signInScreen = '/account/recordList';
  static String secondPage = '/account/secondPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(homePage,
        handler: Handler(handlerFunc: (_, __) => const HomePage()));
    router.define(secondPage,
        handler: Handler(handlerFunc: (_, __) => const SecondPage()));
    router.define(signInScreen,
        handler: Handler(handlerFunc: (_, __) => const SignInScreen()));

    /*
    router.define(bankSelectPage,
        handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      final int type = int.parse(params['type']?.first ?? '0');
      return BankSelectPage(type: type);
    }));
    
    router.define(goodsEditPage,
        handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      final bool isAdd = params['isAdd']?.first == 'true';
      final bool isScan = params['isScan']?.first == 'true';
      final String url = EncryptUtil.decodeBase64(params['url']?.first ?? '');
      final String heroTag = params['heroTag']?.first ?? 'heroTag';
      return GoodsEditPage(
        isAdd: isAdd,
        isScan: isScan,
        goodsImageUrl: url,
        heroTag: heroTag,
      );
    }));
    
    router.define(orderStatisticsPage,
        handler: Handler(handlerFunc: (_, params) {
      final int index = int.parse(params['index']?.first ?? '0');
      return OrderStatisticsPage(index);
    }));
    
    router.define(inputTextPage,
        handler: Handler(handlerFunc: (context, params) {
      /// 類參數
      final args = context!.settings!.arguments! as InputTextPageArgumentsData;
      return InputTextPage(
        title: args.title,
        hintText: args.hintText,
        content: args.content,
        keyboardType: args.keyboardType,
      );
    }));

    */
  }
}
