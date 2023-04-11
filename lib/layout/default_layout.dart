import 'dart:developer';

import 'package:boardca/common/const/colors.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout(
      {super.key,
      required this.child,
      this.backgroundColor,
      this.title,
      this.bottomNavigationBar,
      this.drawer,
      this.titleImage,
      this.actions,
      this.floatingActionButton,
      this.appBar});
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Image? titleImage;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final AppBar? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar ?? renderAppbar(context),
      drawer: drawer,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppbar(BuildContext context) {
    if (title != null) {
      return AppBar(
        actions: actions,
        backgroundColor: PRIMARY_COLOR,
        foregroundColor: TEXT_COLOR,
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: PRIMARY_COLOR, width: 2)),
        centerTitle: true,
        title: Text(
          title!,
          style:
              const TextStyle(color: BUTTON_COLOR, fontWeight: FontWeight.bold),
        ),
      );
    } else if (titleImage != null) {
      return AppBar(
          backgroundColor: Colors.white,
          foregroundColor: TEXT_COLOR,
          elevation: 1,
          centerTitle: true,
          title: titleImage);
    } else {
      return null;
    }
  }
}
