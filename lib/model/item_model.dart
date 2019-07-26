import '../bindings/notify_property_changed.dart';

class Item extends NotifyPropertyChanged {
  static const countPropertyName = 'count';

  int _count = 0;

  get count => _count;

  void incrementCount() {
    _count++;
    propertyChanged(propertyName: countPropertyName);
  }
}
