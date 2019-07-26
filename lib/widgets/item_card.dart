import 'package:flutter/material.dart';
import '../bindings/binding.dart';
import '../model/item_model.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Color color;
  final Function onTap;

  ItemCard({this.item, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Binding<Item>(
      instance: item,
      rebuildOnPropertyChanged: Item.countPropertyName,
      builder: (_, itemInstance) => InkWell(
        onTap: onTap,
        child: Container(
          color: color,
          child: Center(
            child: Text(itemInstance.count.toString()),
          ),
        ),
      ),
    );
  }
}
