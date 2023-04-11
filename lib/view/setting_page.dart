import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '설정',
        drawer: menu_drawer(),
        child: Column(
          children: [
            Row(
              children: [Text("hi")],
            )
          ],
        ));
  }
}
