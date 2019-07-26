import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import '../bindings/binding.dart';
import '../bindings/instance_provider.dart';
import '../model/main_model.dart';
import 'item_card.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Binding<MainModel>(
        instance: InstanceProvider.of<MainModel>(context),
        rebuildOnPropertyChanged: MainModel.itemsPropertyName,
        builder: (_, mainModel) => mainModel.items == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mainModel.items.length,
                itemBuilder: (context, index) {
                  Color randColor = RandomColor()
                      .randomColor(colorBrightness: ColorBrightness.light);
                  return SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ItemCard(
                        item: mainModel.items[index],
                        color: randColor,
                        onTap: () => mainModel.showDetailed(
                          randColor,
                          index,
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
