import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/data/data.dart';
import '/core/core.dart';
import '/domain/domain.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final SchoolRepository _schoolRepository = SchoolRepository();
  bool showFilter = false;
  String filterName = '';
  final filterController = TextEditingController();

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db.collection('schools').snapshots(),
      builder: (context, snapshot) {
        List<School>? docs = snapshot.data?.docs
            .map((doc) {
              return School.fromJson(doc.data());
            })
            .where((School element) =>
                element.name.toLowerCase().contains(filterName))
            .toList();

        if (snapshot.hasData) {
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
                          showFilter = false;
                        });
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Filter school by name',
                        contentPadding: EdgeInsets.all(0),
                      ),
                    )
                  : const Text('Flutter Firestore'),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      showFilter = !showFilter;
                    });
                  },
                  icon: showFilter
                      ? const Icon(Icons.close)
                      : const Icon(Icons.search),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AppDialog.show(
                  context: context,
                  title: 'School',
                  content: 'Are you sure to create new school',
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await _schoolRepository.addSchool();

                        if (mounted) {
                          AppSnackBar.show(
                            message: "New school added",
                            context: context,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
              child: const Icon(Icons.add),
            ),
            body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                School school = docs[index];

                return ListTile(
                  onTap: () {},
                  onLongPress: () {
                    AppDialog.show(
                      context: context,
                      title: 'Delete',
                      content: 'Are you sure to delete this item?',
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        )
                      ],
                    );
                  },
                  title: Text(school.name),
                  leading: const Icon(Icons.school),
                  iconColor: Theme.of(context).colorScheme.primary,
                  subtitle: Text(
                    '${school.address.streetName} - ${school.address.number} | ${school.address.district}',
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: docs!.length,
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Loading...')),
          body: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
