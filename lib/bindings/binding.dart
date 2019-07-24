import 'package:flutter/widgets.dart';

import 'binding_base.dart';
import 'binding_provider.dart';
import 'notify_property_changed.dart';

class Binding<T extends NotifyPropertyChanged> extends StatefulWidget {
  final T state;
  final Widget Function(BuildContext, T) builder;
  final void Function(T) initialize;
  final String rebuildWhenPropertyChanged;

  Binding({
    @required this.state,
    @required this.builder,
    @required this.rebuildWhenPropertyChanged,
    this.initialize,
  }) : super(key: state.key);

  @override
  _BindingState createState() => _BindingState<T>(
        state: state,
        builder: builder,
        rebuildWhenChanged: rebuildWhenPropertyChanged,
        initialize: initialize,
      );
}

class _BindingState<T extends NotifyPropertyChanged> extends State<Binding>
    implements BindingBase<T> {
  final Widget Function(BuildContext, T) builder;
  final void Function(T) initialize;
  final String rebuildWhenChanged;
  BindingProvider bindingProvider;

  @override
  T state;

  _BindingState({
    @required this.state,
    @required this.builder,
    @required this.rebuildWhenChanged,
    this.initialize,
  });

  @override
  void initState() {
    super.initState();
    bindingProvider = BindingProvider.of(context);
    bindingProvider.add(rebuildWhenChanged, this);
    if (initialize != null) {
      initialize(state);
    }
  }

  @override
  void dispose() {
    bindingProvider.remove(rebuildWhenChanged, this);
    super.dispose();
  }

  @override
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, state);
  }
}
