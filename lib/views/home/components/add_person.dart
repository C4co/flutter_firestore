import 'package:flutter/material.dart';
import '/core/core.dart';
import '/data/data.dart';

class AddPerson extends StatelessWidget {
  AddPerson({super.key});

  final PersonRepository _personRepository = PersonRepository();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Person',
          content: 'Are you sure to create new person',
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await _personRepository.addPerson();

                if (context.mounted) {
                  AppSnackBar.show(
                    message: "New person added",
                    context: context,
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
