import 'package:boardca/common/slidepageroute.dart';
import 'package:boardca/common/utils/member_sheets.dart';
import 'package:boardca/provider/member_provider.dart';
import 'package:boardca/view/page_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/utils/books_sheets.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mSheets.initalWorksheet().then((value) {
      bSheets.initalWorksheet();
      Navigator.popAndPushNamed(context, '/members');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Text("로딩중입니다."),
          ],
        ),
      ),
    );
  }
}
