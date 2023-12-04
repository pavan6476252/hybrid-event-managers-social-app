import 'package:flutter/material.dart';

class ScaffoldMessageService {
  static showScaffold(
      {required BuildContext context,
      required String title,
      bool error = false}) {
    final color = Theme.of(context).colorScheme;
    // final style = Theme.of(context).textTheme;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: error ? color.error : null,
        content: Text(
          title,
          style: TextStyle(
            color: error ? color.onError : null,
          ),
        )));
  }
}
