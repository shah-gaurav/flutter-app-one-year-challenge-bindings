import '../bindings/notify_property_changed.dart';

class Item extends NotifyPropertyChanged {
  int _count = 0;

  get count => _count;

  void incrementCount() {
    _count++;
    propertyChanged(propertyName: 'count');
  }
}
