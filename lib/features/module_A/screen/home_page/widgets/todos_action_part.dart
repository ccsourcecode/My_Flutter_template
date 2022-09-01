import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:my_template/features/module_A/screen/todo/todo_event.dart';
import 'package:my_template/features/module_A/constants/texts.dart';
import 'package:my_template/features/module_A//providers/todo_provider.dart';

class TodosActionPart extends ConsumerWidget {
  TodosActionPart({
    Key? key,
  }) : super(key: key);

  final textfieldController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.w,
          child: TextField(
            controller: textfieldController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: whatNeedsToBeDoneText,
              labelStyle: TextStyle(fontSize: 20),
            ),
            autocorrect: false,
          ),
        ),
        IconButton(
          onPressed: () {
            ref.read(todoNotifierProvider.notifier).mapEventsToState(
                  TodoTitleChanged(text: textfieldController.value.text),
                );
            ref.read(todoNotifierProvider.notifier).mapEventsToState(
                  const AddTodo(),
                );
            textfieldController.clear();
          },
          icon: const Icon(
            Icons.add,
            color: Colors.indigo,
            size: 35,
          ),
        )
      ],
    );
  }
}
