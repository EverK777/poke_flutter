import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';


abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;
  final Widget child;

  BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key,child: child);

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type)
        ?.widget as BlocProvider<T>;
    if(provider == null){
      throw FlutterError(
        "BlocProvider.of() called with a context that does not contain a Bloc of type $T.",
      );
    }
    return provider.bloc;
  }

  BlocProvider<T> copyWith(Widget child){
    return BlocProvider<T>(
      key: key,
      bloc: bloc,
      child: child,
    );
  }
  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

