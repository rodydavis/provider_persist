import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/index.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Task Manager'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, model, child) {
          if (model?.tasks == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.tasks.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: model.tasks.length,
            itemBuilder: (context, index) {
              final _item = model.tasks[index];
              return ListTile(
                title: Text(_item.name),
              );
            },
          );
        },
      ),
    );
  }
}
