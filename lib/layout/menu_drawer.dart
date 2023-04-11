import 'package:boardca/common/const/colors.dart';
import 'package:boardca/provider/member_provider.dart';
import 'package:boardca/view/page_insert_member.dart';
import 'package:boardca/view/page_member.dart';
import 'package:flutter/material.dart';
import 'package:boardca/common/slidepageroute.dart';
import '../view/page_books.dart';
import '../view/page_insert_expend.dart';
import '../view/setting_page.dart';

class menu_drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80,
            child: const DrawerHeader(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
              ),
              child: SizedBox(),
            ),
          ),
          ListTile(
            title: const Text('회원 관리'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/members');
            },
          ),
          ListTile(
            title: const Text('회원 등록'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                SlideRoute(builder: (context) => const InsertMemberPage()),
              );
            },
          ),
          ListTile(
            title: const Text('지출 등록'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                SlideRoute(builder: (context) => const InsertExpendPage()),
              );
            },
          ),
          ListTile(
            title: const Text('장부 관리'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                SlideRoute(builder: (context) => const BooksPage()),
              );
            },
          ),
          ListTile(
            title: const Text('설정'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                SlideRoute(builder: (context) => const SettingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
