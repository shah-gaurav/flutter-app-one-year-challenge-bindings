import 'package:flutter/material.dart';

import 'bindings/binding_provider.dart';
import 'model/main_model.dart';
import 'widgets/item_detail_view.dart';
import 'widgets/item_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return BindingProvider(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ItemListView(mainModel: mainModel),
              Divider(),
              ItemDetailView(mainModel: mainModel)
            ],
          ),
        ),
      ),
    );
  }
}
