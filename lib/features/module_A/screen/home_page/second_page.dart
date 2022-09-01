import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/features/module_A/model/todo_model.dart';
import 'package:my_template/core/iview/home_iview.dart';
import 'package:my_template/core/mvp/base_page.dart';
import 'package:my_template/core/mvp/power_presenter.dart';
import 'package:my_template/features/module_A/screen/home_page/constants/texts.dart';
import 'package:my_template/features/module_A/screen/home_page/widgets/todos_action_part.dart';
import 'package:my_template/features/module_A/screen/home_page/widgets/todos_part.dart';
import 'package:my_template/core/home/home_presenter.dart';
import 'package:my_template/features/module_A/providers/todo_provider.dart';

class SecondPage extends ConsumerStatefulWidget {
  const SecondPage({
    super.key,
    this.isAccessibilityTest = false,
  });
  final bool isAccessibilityTest;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage>
    with BasePageMixin<SecondPage, PowerPresenter<dynamic>>
    implements HomeIMvpView {
  @override
  bool get isAccessibilityTest => widget.isAccessibilityTest;

  @override
  Widget build(BuildContext context) {
    debugPrint("at page 3 second page");

    final todoList =
        ref.watch(todoNotifierProvider.select((state) => state.todoList));
    final reversedTodoList = List<TodoModel>.from(todoList.reversed);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  titleText,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              TodosActionPart(),
              TodosPart(todoList: reversedTodoList),
              FloatingActionButton(onPressed: () async {
                debugPrint("Debug preint key pressed");
                debugPrint("key pressed");
                _homePresenter.search("_keyword", 1, true);
              })
            ],
          ),
        ),
      ),
    );
  }

  late HomePagePresenter _homePresenter;

  @override
  PowerPresenter<dynamic> createPresenter() {
    final PowerPresenter<dynamic> powerPresenter =
        PowerPresenter<dynamic>(this);
    _homePresenter = HomePagePresenter();
    powerPresenter.requestPresenter([_homePresenter]);
    return powerPresenter;
  }
}
