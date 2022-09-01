import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/features/module_A/screen/todo/todo_notifier.dart';
import 'package:my_template/features/module_A/screen/todo/todo_state.dart';

final todoNotifierProvider = StateNotifierProvider<TodoNotifier, TodoState>(
  (ref) {
    return TodoNotifier();
  },
);
