import 'package:boardca/view/page_Loading.dart';
import 'package:boardca/view/page_books.dart';
import 'package:boardca/view/page_insert_expend.dart';
import 'package:boardca/view/page_insert_member.dart';
import 'package:boardca/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boardca/view/page_member.dart';
import 'package:boardca/common/const/colors.dart';
import 'package:logger/logger.dart';

var logger = Logger();
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '보드카',
        theme: ThemeData(
          primaryColor: PRIMARY_COLOR,
        ),
        home: const LoadingPage(),
        initialRoute: '/',
        routes: {
          '/members': (context) => const MemberPage(),
          '/members/insert': (context) => const InsertMemberPage(),
          '/books': (context) => const BooksPage(),
          '/books/insert': (context) => const InsertExpendPage(),
          '/setting': (context) => const SettingPage(),
        });
  }
}
