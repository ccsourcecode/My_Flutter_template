import 'package:flutter/material.dart';
import 'package:my_template/core/home/home_page.dart';
import 'package:my_template/features/module_A/screen/counter/counter_page.dart';
import 'package:my_template/features/module_A/screen/home_page/second_page.dart';

enum TabItem { nowPlaying, favourites, profiles }

class TabBarBuilder extends StatefulWidget {
  const TabBarBuilder({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(BuildContext, TabItem) builder;

  @override
  _TabBarBuilderState createState() => _TabBarBuilderState();
}

class _TabBarBuilderState extends State<TabBarBuilder> {
  final TabItem _currentTab = TabItem.nowPlaying;
  final List<Tab> myTabs = <Tab>[
      const Tab(text: '首頁'),
      const Tab(text: '聊天室'),
      const Tab(text: '個人資料'),
    ];

  final pages = [const HomePage(), const SecondPage(), CounterPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: myTabs.length, //選項卡頁數
        child: Scaffold(
          appBar: AppBar(
            title: const Text("線上教室"),
            bottom: TabBar(
              tabs: myTabs,
            ),
          ),
          body: TabBarView(
            children: <Widget>[const HomePage(), const SecondPage(), CounterPage()],
          ),
        ),
      ),
    );
  }
}
