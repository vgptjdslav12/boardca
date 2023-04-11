import 'package:flutter/material.dart';

class SlideRoute<T> extends MaterialPageRoute<T> {
  SlideRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: const Offset(-2, 0), end: Offset.zero)
            .animate(animation),
        child: child);
  }
}
