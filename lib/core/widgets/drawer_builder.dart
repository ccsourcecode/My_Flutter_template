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
   //目前選擇頁索引值
  int _currentIndex = 0; //預設值
  final pages = [const HomePage(), const SecondPage(), CounterPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('線上教室'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //設定用户名稱
            const UserAccountsDrawerHeader(
              accountName: Text("線上教室",),
              //設定Email
              accountEmail: Text("thishkt@gmail.com",),
              //設定大頭照
              currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("assets/images/logo.png"), ),
            ),
            //選單
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.chrome_reader_mode)),
              title: const Text('從零開始學 Java 程式設計'),
              onTap: () { _onItemClick(0); },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.code)),
              title: const Text('從零開始學 Kotlin 程式設計'),
              onTap: () { _onItemClick(1); },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.computer)),
              title: const Text('從零開始學 Flutter 程式設計'),
              onTap: () { _onItemClick(2); },
            ),
          ],
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.of(context).pop();
    });
  }
}