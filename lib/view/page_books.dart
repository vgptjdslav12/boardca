import 'package:boardca/common/const/font.dart';
import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';

import '../common/const/colors.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final String title = '장부 관리';
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: title,
      drawer: menu_drawer(),
      appBar: appBar(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 0),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text("이용 내역",
                  style: TextStyle(
                    fontSize: LARGE_FONT_SIZE,
                    fontWeight: FontWeight.bold,
                  )),
              trailing: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      flex: 8,
                      child: Text("금액",
                          style: TextStyle(
                              fontSize: LARGE_FONT_SIZE,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 9,
                      child: Text("날짜",
                          style: TextStyle(
                              fontSize: LARGE_FONT_SIZE,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            //tile은 반드시 10개씩 생성
            tile("문국원 4 회권", "40,000", "2023-06-21"),
            tile("허수영 3 달 갱신", "96,000", "2023-04-11"),
            tile("박성현 4 회권", "40,000", "2023-04-11"),
            tile("주진수 3 달 갱신", "96,000", "2023-03-25"),
            tile("아지트 월세", "-350,000", "2023-03-15"),
            tile("아이스티 구매", "-12,000", "3050-12-31"),
            tile("핫초코 구매", "-15,000", "9999-12-31"),
            tile("간식비", "-25,000", "2023-03-16"),
            tile("윤종현 3 달 갱신", "96,000", "2021-04-08"),
            tile("황승준 3 달 갱신", "96,000", "2021-06-23"),
            tile("지니어스 우승상품", "-128,000", "2021-06-23"),
            tile("지니어스 준 우승상품", "-40,000", "2021-06-23"),
            const Text(
              "1  2  3  4  >>",
              style: TextStyle(
                  fontSize: DEFUALT_FONT_SIZE, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  ListTile tile(String history, String money, String date) {
    return ListTile(
      onTap: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) => cogDialog(history, money, date))
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
      title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(history,
              style: const TextStyle(
                  fontSize: DEFUALT_FONT_SIZE + 1,
                  fontWeight: FontWeight.bold))),
      trailing: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: FittedBox(
                alignment: Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text("$money 원",
                    style: const TextStyle(
                        fontSize: DEFUALT_FONT_SIZE + 1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox()),
            Expanded(
              flex: 9,
              child: FittedBox(
                alignment: Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text(date,
                    style: const TextStyle(
                        fontSize: DEFUALT_FONT_SIZE,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: PRIMARY_COLOR,
      foregroundColor: TEXT_COLOR,
      elevation: 0,
      shape: const Border(bottom: BorderSide(color: PRIMARY_COLOR, width: 2)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => print("search"), // dialog
        ),
      ],
      title: Text(
        title,
        style:
            const TextStyle(color: BUTTON_COLOR, fontWeight: FontWeight.bold),
      ),
    );
  }

  Dialog cogDialog(String history, String money, String date) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.38,
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        "내역",
                        style: TextStyle(
                            fontSize: DIALOG_FONT_SIZE,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        history,
                        style: const TextStyle(
                            fontSize: DIALOG_FONT_SIZE,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        "금액",
                        style: TextStyle(
                            fontSize: DIALOG_FONT_SIZE,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$money  원",
                            style: const TextStyle(
                                fontSize: DIALOG_FONT_SIZE,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "날짜",
                      style: TextStyle(
                          fontSize: DIALOG_FONT_SIZE,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        date,
                        style: const TextStyle(
                            fontSize: DIALOG_FONT_SIZE,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ))
                ],
              ),
              const SizedBox(height: 6),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text("수정"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text("삭제"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: const Text("확인"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
