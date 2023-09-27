import 'package:flutter/material.dart';

import 'ui/json_to_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Reconcile Task",
      home: JsonToDart(),
    );
  }
}
