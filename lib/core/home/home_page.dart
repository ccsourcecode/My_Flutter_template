import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/core/home/provider/home_provider.dart';
import 'package:my_template/features/module_A/screen/home_page/second_page.dart';
import 'package:my_template/features/module_A/screen/home_page/sign_in_screen.dart';
import 'package:my_template/core/constants/images.dart';
import 'package:my_template/core/utils/theme_utils.dart';
import 'package:my_template/core/widgets/load_image_widget.dart';
import 'package:my_template/core/widgets/double_tap_back_exit_app_widget.dart';

final indexProvider = StateNotifierProvider((ref) => Index());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with RestorationMixin {
  static const double _imageSize = 25.0;

  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['訂單', '商品', '統計', '店鋪'];
  final PageController _pageController = PageController();

  final homeProvider = StateProvider<RestorableInt>((ref) {
    return RestorableInt(0);
  });
  // HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const SecondPage(),
      const SignInScreen(),
      const HomePage(),
      const SecondPage(),
      // const SecondPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const tabImages = [
        [
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ]
      ];
      _list = List.generate(tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImages[i][0],
          activeIcon: tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const tabImagesDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ]
      ];

      _listDark = List.generate(tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImagesDark[i][0],
          activeIcon: tabImagesDark[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("at page 1 homepage");
    final bool isDark = context.isDark;
    // final homeProvider = StateProvider<RestorableInt>((ref) {
    //   return RestorableInt(0);
    // });
    final int menuIndex = ref.watch(indexProvider) as int;

    return DoubleTapBackExitApp(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.backgroundColor,
          items: isDark
              ? _buildDarkBottomNavigationBarItem()
              : _buildBottomNavigationBarItem(),
          type: BottomNavigationBarType.fixed,
          currentIndex: ref.read(homeProvider.notifier).state.value,
          elevation: 5.0,
          iconSize: 21.0,
          selectedFontSize: Dimens.font_p10,
          unselectedFontSize: Dimens.font_p10,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: isDark
              ? Colours.dark_unselected_item_color
              : Colours.unselected_item_color,
          onTap: (index) => _pageController.jumpToPage(index),
        ),
        // 使用PageView的原因參看 https://zhuanlan.zhihu.com/p/58582876
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 禁止滑動
          controller: _pageController,
          // onPageChanged: (int index) => ref.watch(homeProvider.notifier).state.value = index,
          onPageChanged: (i) => ref.read(indexProvider.notifier).value = i,
          children: _pageList,
        ),
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint("hit restoreState");
    registerForRestoration(ref.watch(homeProvider.notifier).state,
        'BottomNavigationBarCurrentIndex');
  }
}
