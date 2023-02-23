import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './components/loading_page.dart';
import './components/error_page.dart';
import './components/empty_list_page.dart';
import './components/list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db.collection('people').snapshots(),
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
          return ListPage(snapshot: snapshot, context: context);
        }

        // empty list
        if (hasNoData) {
          return const EmptyListPage();
        }

        // error
        if (snapshot.hasError) {
          return ErrorPage(errorMessage: snapshot.error.toString());
        }

        // loading
        return const LoadingPage();
      },
    );
  }
}
