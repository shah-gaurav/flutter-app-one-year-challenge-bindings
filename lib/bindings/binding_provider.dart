import 'package:flutter/widgets.dart';

import 'binding_base.dart';

Type _typeOf<T>() => T;

class BindingProvider extends InheritedWidget {
  final _instancesToNotify = Map<String, List<BindingBase>>();

  BindingProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static BindingProvider of(BuildContext context) {
    final type = _typeOf<BindingProvider>();
    final provider = context
        .ancestorInheritedElementForWidgetOfExactType(type)
        ?.widget as BindingProvider;

    return provider;
  }

  void add(String rebuildWhenPropertyChanged, BindingBase instance) {
    if (!_instancesToNotify.containsKey(rebuildWhenPropertyChanged)) {
      _instancesToNotify[rebuildWhenPropertyChanged] = List<BindingBase>();
    }
    if (!_instancesToNotify[rebuildWhenPropertyChanged].contains(instance)) {
      instance.state.callback = propertyChanged;
      _instancesToNotify[rebuildWhenPropertyChanged].add(instance);
    }
  }

  void remove(String rebuildWhenPropertyChanged, BindingBase instance) {
    if (!_instancesToNotify.containsKey(rebuildWhenPropertyChanged)) {
      return;
    }
    if (_instancesToNotify[rebuildWhenPropertyChanged].contains(instance)) {
      _instancesToNotify[rebuildWhenPropertyChanged].remove(instance);
    }
  }

  void propertyChanged({String propertyName, Key key}) {
    if (_instancesToNotify.containsKey(propertyName)) {
      for (var instance in _instancesToNotify[propertyName]) {
        if (instance.state.key == key) {
          instance.rebuild();
        }
      }
    }
  }
}
