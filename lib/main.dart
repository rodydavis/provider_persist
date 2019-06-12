import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/data/models/index.dart';
import 'src/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableProvider.value(
      value: TaskProvider()..init(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TasksScreen(),
      ),
    );
  }
}
