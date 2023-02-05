import 'package:flutter/material.dart';

class AppBottomSheet {
  static show({
    required BuildContext context,
    required List<Widget> content,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext contextContext) {
        return Container(
          height: 1000,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: content,
          ),
        );
      },
    );
  }
}
