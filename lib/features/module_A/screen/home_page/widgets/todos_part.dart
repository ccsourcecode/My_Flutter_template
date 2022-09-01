import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:my_template/features/module_A/screen/todo/todo_event.dart';
import 'package:my_template/features/module_A/model/todo_model.dart';
import 'package:my_template/features/module_A/constants/colors.dart';
import 'package:my_template/features/module_A/providers/todo_provider.dart';

class TodosPart extends ConsumerWidget {
  const TodosPart({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  final List<TodoModel> todoList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return todoList.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text(
              "There is no To do",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            width: 100.h,
            height: 130.w,
            // ListView 通常搭配 ListTile 一起使用
            // 當需要大量資料時建議使用 ListView.builder 來建立列表資料。
            // ListView 和 ListView.builder 最大的差異是 
            // ListView 是一次建立完所有列表資料，如果記憶體沒有管理好很容易造成APP閃退，
            // ListView.builder 則是當元件滾動到螢幕當下才進行創建。
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 100.w,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: blackColor,
                              fillColor: MaterialStateProperty.all(whiteColor),
                              value: todoList[index].isTodoCompleted,
                              onChanged: (isTodoCompleted) {
                                ref.read(todoNotifierProvider.notifier).mapEventsToState(
                                      TodoStatusChanged(todoId: todoList[index].id),
                                    );
                              },
                            ),
                            Text(
                              todoList[index].title,
                              style: const TextStyle(fontSize: 25, color: whiteColor),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(todoNotifierProvider.notifier).mapEventsToState(
                                  RemoveTodo(
                                    todoId: todoList[index].id,
                                  ),
                                );
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
