import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import 'bindings/binding.dart';
import 'bindings/binding_provider.dart';
import 'model/main_model.dart';
import 'model/item_model.dart';
import 'widgets/item_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
              Container(
                height: 150,
                child: Binding<MainModel>(
                  instance: mainModel,
                  initialize: (mainModel) => mainModel.getItems(),
                  rebuildOnPropertyChanged: 'items',
                  builder: (_, mainModel) => mainModel.items == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mainModel.items.length,
                          itemBuilder: (context, index) {
                            Color randColor = RandomColor().randomColor(
                                colorBrightness: ColorBrightness.light);
                            return SizedBox(
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Binding<Item>(
                                  instance: mainModel.items[index],
                                  rebuildOnPropertyChanged: 'count',
                                  builder: (_, item) => ItemCard(
                                    item: item,
                                    color: randColor,
                                    onTap: () => mainModel.showDetailed(
                                      randColor,
                                      index,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ),
              Divider(),
              Center(
                child: Binding<MainModel>(
                  instance: mainModel,
                  rebuildOnPropertyChanged: 'detailedIndex',
                  builder: (_, mainModel) => mainModel.detailedIndex == null
                      ? Container()
                      : SizedBox(
                          width: 200,
                          height: 200,
                          child: Binding<Item>(
                            instance: mainModel.items[mainModel.detailedIndex],
                            rebuildOnPropertyChanged: 'count',
                            builder: (_, item) => ItemCard(
                              item: item,
                              color: mainModel.detailedColor,
                              onTap: () => item.incrementCount(),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
