import 'package:boardca/common/const/font.dart';
import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';

class InsertExpendPage extends StatefulWidget {
  const InsertExpendPage({Key? key}) : super(key: key);

  @override
  _ExpendPageState createState() => _ExpendPageState();
}

class _ExpendPageState extends State<InsertExpendPage> {
  var currentTicket = 0;

  @override
  void initState() {
    super.initState();
    currentTicket = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '지출 등록',
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
                Text("지출 등록",
                    style: TextStyle(
                        fontSize: LARGE_FONT_SIZE, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "지출 내역", hintText: "지출 내역을 입력해주세요."),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                inputFormatters: [
                  MultiMaskedTextInputFormatter(masks: [
                    'xxx',
                    'x,xxx',
                    'xx,xxx',
                    'xxx,xxx',
                    'x,xxx,xxx',
                    'xx,xxx,xxx',
                    'xxx,xxx,xxx',
                    'x,xxx,xxx,xxx'
                  ], separator: ',')
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "가격", hintText: "가격을 입력해주세요."),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              width: 150,
              child: ElevatedButton(
                onPressed: () => {
                  setState(() => {currentTicket = 0})
                },
                child: const Text("초기화"),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
