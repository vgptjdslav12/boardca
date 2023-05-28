import 'package:boardca/common/const/font.dart';
import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/const/colors.dart';
import '../common/const/const.dart';
import '../common/utils/books_sheets.dart';
import '../model/books_model.dart';
import '../provider/books_provider.dart';

class BooksPage extends ConsumerStatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksPage> {
  final String title = '장부 관리';
  var num = 1;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print(bSheets.amount);
  }

  @override
  void initState() {
    super.initState();
    bSheets.initalWorksheet().then((value) {
      ref.read(booksProvider.notifier).getBooks(1, bSheets);
    });
  }

  @override
  Widget build(BuildContext context) {
    var booksList = ref.watch(booksProvider) as BooksModel;
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
            if (booksList.list.isNotEmpty) ...[
              for (var i in booksList.list) ...[
                Expanded(
                  flex: 1,
                  child: tile(i),
                )
              ],
              for (var i = booksList.list.length; i < 10; i++) ...[
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ] else ...[
              const CircularProgressIndicator(),
              const Text('로딩중입니다...'),
            ],
            Row(
              children: [
                for (var i = 1; i < bSheets.amount! / 10 + 1; i++) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        num = i;
                        ref.read(booksProvider.notifier).getBooks(i, bSheets);
                      });
                    },
                    child: Text(
                      i.toString(),
                      style: const TextStyle(
                          fontSize: DEFUALT_FONT_SIZE,
                          fontWeight: FontWeight.bold,
                          color: TEXT_COLOR),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile tile(BooksInnerModel model) {
    var history = model.history;
    var cost =
        formatCurrency.format(int.parse(model.cost)).toString().substring(1);
    var date = model.date;
    return ListTile(
      onTap: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                cogDialog(history, cost, date, model.index))
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
                child: Text("$cost 원",
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

  Dialog cogDialog(String history, String cost, String date, int index) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.38,
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 12, 30, 12),
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
                            "$cost  원",
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
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        bSheets.deleteSheets(index, num);
                      },
                      child: const Text("삭제"),
                    ),
                  ),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
