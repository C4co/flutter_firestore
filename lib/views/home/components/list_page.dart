import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_person.dart';
import '/core/core.dart';
import '/domain/domain.dart';

class ListPage extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final BuildContext context;

  const ListPage({
    super.key,
    required this.snapshot,
    required this.context,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final filterController = TextEditingController();
  bool showFilter = false;
  String filterName = '';

  @override
  void dispose() {
    filterController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Person>? filteredDocs = widget.snapshot.data!.docs
        .map((doc) {
          return Person.fromJson(doc.data());
        })
        .where(
          (Person element) => element.name.toLowerCase().contains(filterName),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: showFilter
            ? TextFormField(
                controller: filterController,
                style: const TextStyle(fontSize: 16),
                autofocus: true,
                onChanged: (String value) {
                  setState(() {
                    filterName = value;
                  });
                },
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).unfocus();
                  filterController.clear();
                  setState(() {
                    filterName = '';
                    filterController.clear();
                    showFilter = false;
                  });
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Filter person by name',
                  contentPadding: EdgeInsets.all(0),
                ),
              )
            : const Text('Flutter Firestore'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                filterName = '';
                filterController.clear();
                showFilter = !showFilter;
              });
            },
            icon:
                showFilter ? const Icon(Icons.close) : const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: AddPerson(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          Person person = filteredDocs[index];

          return ListTile(
            onTap: () {},
            onLongPress: () {
              AppDialog.show(
                context: context,
                title: 'Delete ${person.id}',
                content: 'Are you sure to delete this item?',
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);

                      try {
                        await _db.collection('people').doc(person.id).delete();

                        if (mounted) {
                          AppSnackBar.show(
                            message: 'Item deleted',
                            context: context,
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          AppSnackBar.show(
                            message: e.toString(),
                            context: context,
                          );
                        }
                      }
                    },
                    child: const Text('Yes'),
                  )
                ],
              );
            },
            title: Text(person.name),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(person.image),
            ),
            iconColor: Theme.of(context).colorScheme.primary,
            subtitle: Text(
              person.email,
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: filteredDocs.length,
      ),
    );
  }
}
