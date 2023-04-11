import 'package:boardca/common/const/font.dart';
import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';

class InsertMemberPage extends StatefulWidget {
  const InsertMemberPage({Key? key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<InsertMemberPage> {
  var currentTicket = 0;

  @override
  void initState() {
    super.initState();
    currentTicket = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원 등록',
      drawer: menu_drawer(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("신규 회원 등록",
                    style: TextStyle(
                        fontSize: LARGE_FONT_SIZE, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "이름", hintText: "이름을 입력해주세요."),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                inputFormatters: [
                  MultiMaskedTextInputFormatter(
                      masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "전화번호", hintText: "전화번로를 입력해주세요."),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              width: 150,
              child: ElevatedButton(
                onPressed: () => {},
                child: const Text("등록"),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 4, 18, 0),
              child: const Divider(
                color: Colors.black,
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
