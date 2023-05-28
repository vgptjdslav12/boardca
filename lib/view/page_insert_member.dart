import 'package:boardca/common/const/font.dart';
import 'package:boardca/common/utils/member_sheets.dart';
import 'package:boardca/model/member_model.dart';
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
  String? name;
  String? phone;

  @override
  void initState() {
    super.initState();
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
                onChanged: (newValue) {
                  name = newValue;
                },
                decoration: const InputDecoration(
                    labelText: "이름", hintText: "이름을 입력해주세요."),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                onChanged: (newValue) {
                  phone = newValue;
                  print(phone);
                },
                inputFormatters: [
                  MultiMaskedTextInputFormatter(
                      masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "전화번호", hintText: "전화번호를 입력해주세요."),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  String ticket = 0.toString();
                  String date = DateTime.now().toString().substring(0, 10);
                  int index = mSheets.amount! + 2;
                  final model = MemberInnerModel(
                      name: name!,
                      phone: phone!,
                      ticket: ticket,
                      date: date,
                      index: index);
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => acceptDialog(model));
                  });
                },
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

  Dialog acceptDialog(MemberInnerModel model) {
    return Dialog(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "정말 등록하시겠습니까?",
                  style: TextStyle(
                      fontSize: DEFUALT_FONT_SIZE, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          mSheets.insertSheets(model);
                          Navigator.pop(context);
                        },
                        child: const Text("예")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("아니오")),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
