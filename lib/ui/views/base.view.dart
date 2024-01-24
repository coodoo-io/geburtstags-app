import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/viewmodels/base.viewmodel.dart';
import 'package:geburtstags_app/locator.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;

  const BaseView({required this.builder, required this.onModelReady, super.key});

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.onModelReady(model));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
