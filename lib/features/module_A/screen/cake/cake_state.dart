import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/features/module_A/service/sembast_cake_repository.dart';

final cakesProvider = StreamProvider(
  (ref) => ref.watch(cakeRepositoryProvider).getAllCakesStream(),
);
