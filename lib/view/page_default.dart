import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';

class InsertMemberPage extends StatefulWidget {
  const InsertMemberPage({Key? key}) : super(key: key);

  static String get routerName => "member_insert";

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<InsertMemberPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '회원 등록',
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
