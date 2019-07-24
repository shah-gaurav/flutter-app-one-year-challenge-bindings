import 'package:flutter/material.dart';

import '../bindings/notify_property_changed.dart';
import 'item_model.dart';
import 'item_provider.dart';

class MainModel extends NotifyPropertyChanged {
  final itemProvider = ItemProvider();

  List<Item> items;
  Color detailedColor; // The color of the tapped card from the ListView
  int detailedIndex; // The index of the tapped card from the ListView

  void getItems() async {
    items = await itemProvider.fetchItems();

    propertyChanged(propertyName: 'items');
  }

  void showDetailed(Color color, int index) {
    detailedColor = color;
    detailedIndex = index;

    propertyChanged(propertyName: 'detailedColor');
    propertyChanged(propertyName: 'detailedIndex');
  }
}
