import 'package:flutter/material.dart';
import '../model/item_model.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Color color;
  final Function onTap;

  ItemCard({this.item, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        child: Center(
          child: Text(item.count.toString()),
        ),
      ),
    );
  }
}
