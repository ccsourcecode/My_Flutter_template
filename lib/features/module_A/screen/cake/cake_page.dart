import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/features/module_A/screen/cake/cake_controller.dart';
import 'package:my_template/features/module_A/screen/cake/cake_state.dart';

class CakePage extends ConsumerWidget {
  const CakePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cakeControllerProvider);
    //? Since the stream will automatically update, there is no need to query the database manually
    //? The StreamProvider returns an AsyncValue.
    //? This class gives us access to a when function to handle different states of the stream.
    //? We can specify widgets for loading, error, and data (success) state.
    final cakes = ref.watch(cakesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Cakes'),
      ),
      body: cakes.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, trace) => Center(child: Text(error.toString())),
          data: (cakes) => ListView.builder(
                itemCount: cakes.length,
                itemBuilder: (context, index) {
                  final cake = cakes[index];
                  return ListTile(
                    title: Text(cake.name),
                    subtitle: Text('Yummyness: ${cake.yummyness}'),
                    leading: IconButton(
                      icon: const Icon(Icons.thumb_up),
                      onPressed: () => controller.edit(cake),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => controller.delete(cake),
                    ),
                  );
                },
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => controller.add(),
      ),
    );
  }
}
