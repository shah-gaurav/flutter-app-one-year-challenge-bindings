import 'package:flutter/widgets.dart';

import 'binding_base.dart';
import 'binding_provider.dart';
import 'notify_property_changed.dart';

class Binding<T extends NotifyPropertyChanged> extends StatefulWidget {
  final T instance;
  final Widget Function(BuildContext, T) builder;
  final String rebuildOnPropertyChanged;

  Binding({
    @required this.instance,
    @required this.builder,
    @required this.rebuildOnPropertyChanged,
  }) : super(key: instance.key);

  @override
  _BindingState createState() => _BindingState<T>(
        instance: instance,
        builder: builder,
        rebuildOnPropertyChanged: rebuildOnPropertyChanged,
      );
}

class _BindingState<T extends NotifyPropertyChanged> extends State<Binding>
    implements BindingBase<T> {
  final Widget Function(BuildContext, T) builder;
  final String rebuildOnPropertyChanged;
  BindingProvider bindingProvider;

  @override
  T instance;

  _BindingState({
    @required this.instance,
    @required this.builder,
    @required this.rebuildOnPropertyChanged,
  });

  @override
  void initState() {
    super.initState();
    bindingProvider = BindingProvider.of(context);
    bindingProvider.add(rebuildOnPropertyChanged, this);
  }

  @override
  void dispose() {
    bindingProvider.remove(rebuildOnPropertyChanged, this);
    super.dispose();
  }

  @override
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, instance);
  }
}
