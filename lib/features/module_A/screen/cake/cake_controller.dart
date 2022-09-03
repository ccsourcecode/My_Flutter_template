import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/features/module_A/model/cake.dart';
import 'package:my_template/features/module_A/service/cake_repository.dart';
import 'package:my_template/features/module_A/service/sembast_cake_repository.dart';

final cakeControllerProvider = Provider(
  (ref) => CakeController(
    cakeRepository: ref.watch(cakeRepositoryProvider),
  ),
);

class CakeController {
  static const flavors = ['apple', 'orange', 'chocolate'];
  final CakeRepository cakeRepository;

  CakeController({required this.cakeRepository});

  Future<void> delete(Cake cake) async {
    await cakeRepository.deleteCake(cake.id);
  }

  Future<void> edit(Cake cake) async {
    final updatedCake = cake.copyWith(yummyness: cake.yummyness + 1);
    await cakeRepository.updateCake(updatedCake);
  }

  Future<void> add() async {
    final flavorIndex = Random().nextInt(flavors.length - 1);

    final list = flavors..shuffle();
    final name = "My yummy ${list.first} cake";
    // final name = 'My yummy ${flavors[flavorIndex]} cake';
    final yummyness = Random().nextInt(10);
    final newCake = Cake(name: name, yummyness: yummyness);
    await cakeRepository.insertCake(newCake);
  }
}
