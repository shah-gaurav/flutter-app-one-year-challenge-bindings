import 'package:flutter/material.dart';
import '../bindings/binding.dart';
import '../model/main_model.dart';
import 'item_card.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({
    Key key,
    @required this.mainModel,
  }) : super(key: key);

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Binding<MainModel>(
        instance: mainModel,
        rebuildOnPropertyChanged: 'detailedIndex',
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
