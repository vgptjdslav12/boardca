import 'package:boardca/common/const/font.dart';
import 'package:boardca/model/books_model.dart';
import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';

import '../common/utils/books_sheets.dart';

class InsertExpendPage extends StatefulWidget {
  const InsertExpendPage({Key? key}) : super(key: key);

  @override
  _ExpendPageState createState() => _ExpendPageState();
}

class _ExpendPageState extends State<InsertExpendPage> {
  String? history;
  String? cost;

  @override
  void initState() {
    super.initState();
    history = "";
    cost = "0";
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
                onChanged: (value) {
                  history = value;
                },
                decoration: const InputDecoration(
                    labelText: "지출 내역", hintText: "지출 내역을 입력해주세요."),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                onChanged: (value) {
                  cost = value;
                },
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
                    labelText: "비용", hintText: "비용을 입력해주세요."),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  String date = DateTime.now().toString().substring(0, 10);
                  int index = bSheets.amount! + 2;
                  final model = BooksInnerModel(
                      history: history!, cost: cost!, date: date, index: index);
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
            ),
          ],
        ),
      ),
    );
  }

  Dialog acceptDialog(BooksInnerModel model) {
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
                          print(model.history);
                          bSheets.insertSheets(model);
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
