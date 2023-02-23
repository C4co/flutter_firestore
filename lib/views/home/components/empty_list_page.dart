import 'package:flutter/material.dart';
import 'add_person.dart';

class EmptyListPage extends StatelessWidget {
  const EmptyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Firebase')),
      floatingActionButton: AddPerson(),
      body: Center(
        child: Text(
          'No items',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
