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
  final filterController = TextEditingController();
  bool showFilter = false;
  String filterName = '';

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  Widget addNewSchool() {
    return FloatingActionButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'School',
          content: 'Are you sure to create new school',
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await _schoolRepository.addSchool();

                if (mounted) {
                  AppSnackBar.show(
                    message: "New school added",
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

  Widget loadingPage() {
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
  }

  Widget errorPage(AsyncSnapshot snapshot) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text(
          snapshot.error.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }

  Widget emptyListPage() {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Firebase')),
      floatingActionButton: addNewSchool(),
      body: Center(
        child: Text(
          'No items',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }

  Widget listPage(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
    BuildContext context,
  ) {
    List<School>? filteredDocs = snapshot.data!.docs
        .map((doc) {
          Map<String, dynamic> myDoc = {'id': doc.id};
          myDoc.addAll(doc.data());
          return School.fromJson(myDoc);
        })
        .where(
          (School element) => element.name.toLowerCase().contains(filterName),
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
                  hintText: 'Filter school by name',
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
          )
        ],
      ),
      floatingActionButton: addNewSchool(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          School school = filteredDocs[index];

          return ListTile(
            onTap: () {},
            onLongPress: () {
              AppDialog.show(
                context: context,
                title: 'Delete ${school.id}',
                content: 'Are you sure to delete this item?',
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);

                      try {
                        await _db.collection('schools').doc(school.id).delete();

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
            title: Text(school.name),
            leading: const Icon(Icons.school),
            iconColor: Theme.of(context).colorScheme.primary,
            subtitle: Text(
              '${school.address.streetName} - ${school.address.number} | ${school.address.district}',
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: filteredDocs.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db.collection('schools').snapshots(),
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        bool hasData = snapshot.data != null &&
            snapshot.hasData &&
            snapshot.data!.docs.isNotEmpty;

        bool hasNoData = snapshot.data != null &&
            snapshot.hasData &&
            snapshot.data!.docs.isEmpty;

        if (hasData) {
          return listPage(snapshot, context);
        }

        // empty list
        if (hasNoData) {
          return emptyListPage();
        }

        // error
        if (snapshot.hasError) {
          return errorPage(snapshot);
        }

        // loading
        return loadingPage();
      },
    );
  }
}
