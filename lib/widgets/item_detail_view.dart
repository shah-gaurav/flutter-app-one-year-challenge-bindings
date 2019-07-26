import 'package:flutter/material.dart';
import '../bindings/instance_provider.dart';
import '../bindings/binding.dart';
import '../model/main_model.dart';
import 'item_card.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Binding<MainModel>(
        instance: InstanceProvider.of<MainModel>(context),
        rebuildOnPropertyChanged: MainModel.detailedIndexPropertyName,
        builder: (_, mainModel) => mainModel.detailedIndex == null
            ? Container()
            : SizedBox(
                width: 200,
                height: 200,
                child: ItemCard(
                  item: mainModel.items[mainModel.detailedIndex],
                  color: mainModel.detailedColor,
                  onTap: () =>
                      mainModel.items[mainModel.detailedIndex].incrementCount(),
                ),
              ),
      ),
    );
  }
}
