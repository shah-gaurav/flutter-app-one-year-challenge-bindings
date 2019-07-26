import 'package:flutter/widgets.dart';

import 'notify_property_changed.dart';

class InstanceProvider<T extends NotifyPropertyChanged>
    extends InheritedWidget {
  final T instance;
  final void Function(T) initialize;

  InstanceProvider(
      {Key key,
      @required this.instance,
      @required Widget child,
      this.initialize})
      : super(key: key, child: child) {
    if (initialize != null) {
      initialize(instance);
    }
  }

  @override
  bool updateShouldNotify(_) => false;

  static T of<T extends NotifyPropertyChanged>(BuildContext context) {
    final type = _typeOf<InstanceProvider<T>>();

    InstanceProvider<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.instance;
  }

  static Type _typeOf<T>() => T;
}
