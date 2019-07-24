import 'notify_property_changed.dart';

abstract class BindingBase<T extends NotifyPropertyChanged> {
  T state;
  void rebuild();
}
