import 'package:flutter/material.dart';
import 'package:my_template/core/widgets/my_app_bar_widget.dart';
import 'package:my_template/core/widgets/state_layout_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '頁面不存在',
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: '頁面不存在',
      ),
    );
  }
}
