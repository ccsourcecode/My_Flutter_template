import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeIndex extends RestorableInt {
  HomeIndex() : super(0);
}

class Index extends StateNotifier<int> {
  Index() : super(0);
  set value(int index) => state = index;
}
