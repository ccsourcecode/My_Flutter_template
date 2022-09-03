import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/core/providers/sembast_provider.dart';
import 'package:my_template/features/module_A/model/cake.dart';
import 'package:my_template/features/module_A/service/cake_repository.dart';
import 'package:sembast/sembast.dart';

final cakeRepositoryProvider = Provider(
  (ref) => SembastCakeRepository(
    database: ref.watch(sembastProvider),
  ),
);

class SembastCakeRepository implements CakeRepository {
  final Database database;
  late final StoreRef<int, Map<String, dynamic>> _store;

  SembastCakeRepository({required this.database}) {
    //? With Sembast we have multiple stores in one database.
    //? Here, we create a reference to our store with the name "cake_store".
    //? Don’t worry, we don’t need to create the store ourselves.
    //? Sembast makes sure we can write to the store
    _store = intMapStoreFactory.store('cake_store');
  }

  @override
  Future<int> insertCake(Cake cake) => _store.add(database, cake.toJson());

  @override
  Future<void> updateCake(Cake cake) =>
      //? with _store.record we can directly access a database record by its ID
      _store.record(cake.id).update(database, cake.toJson());

  @override
  Future deleteCake(int cakeId) => _store.record(cakeId).delete(database);

  @override
  Stream<List<Cake>> getAllCakesStream() =>
      //? an empty query returns all objects
      //? The onSnapshots functions is where Sembast returns us the stream of changes
      _store.query().onSnapshots(database).map(
            //? convert the snapshots into a list of Cakes
            //? Don’t forget to convert the result to a List before returning.
            //? Forgetting this call will lead to error, which is hard to debug.
            (snapshot) => snapshot
                .map((cake) => Cake.fromJson(cake.value).copyWith(id: cake.key))
                .toList(growable: false),
          );
}
