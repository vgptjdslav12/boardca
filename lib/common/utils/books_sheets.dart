import 'dart:ffi';

import 'package:boardca/common/const/gsheetsconfig.dart';
import 'package:boardca/model/books_model.dart';
import 'package:gsheets/gsheets.dart';

final bSheets = BooksSheets();

class BooksSheets {
  final String _workSheetTitle = "books";
  Spreadsheet? spreadSheet;
  Worksheet? workSheet;
  int? amount;

  Future<void> initalWorksheet() async {
    final gSheets = GSheetsconfig.gSheets;
    spreadSheet ??= await gSheets.spreadsheet(GSheetsconfig.spreadSheetId);
    workSheet = spreadSheet!.worksheetByTitle(_workSheetTitle);
    amount = int.parse(await workSheet!.values.value(column: 7, row: 1));
  }

  Future<BooksModel> getSheets(int num) async {
    BooksModel model = BooksModel(num: num, list: []);
    var index = amount! + 2 - ((num - 1) * 10) - 10;
    var cnt = 10;
    if (index < 2) {
      cnt = 10 + index - 2;
      index = 2;
    }
    var t = cnt;
    var list = await workSheet!.values.allRows(fromRow: index, count: cnt);
    for (var i in list) {
      var temp = BooksInnerModel(
          history: i[0] ?? "-",
          cost: i[1] ?? "-",
          date: i[2] ?? "-",
          index: t--);
      model.list.insert(0, temp);
    }
    return model;
  }

  Future<void> updateSheets(BooksModel model, int index, int num) async {
    var list = [
      model.list[index].history,
      model.list[index].cost,
      model.list[index].date
    ];
    await workSheet!.values
        .insertRow(amount! + 1 - index - ((num - 1) * 10), list);
  }

  Future<void> deleteSheets(int index, int num) async {
    await workSheet!.deleteRow(amount! + 2 - index - ((num - 1) * 10));
    amount = int.parse(await workSheet!.values.value(column: 7, row: 1));
    getSheets(num);
  }

  Future<void> insertSheets(BooksInnerModel model) async {
    var index = 2 + amount!;

    await workSheet!.values.insertRow(index, [
      model.history,
      model.cost,
      model.date,
    ]);
    amount = int.parse(await workSheet!.values.value(column: 7, row: 1));
  }

  Future<void> serachSheets(String name) async {
    print(await workSheet!.values.rowByKey(name));
  }

  Future<void> updatedMember(
      String name, int _1ticket, int _4ticket, int _1month, int _3month) async {
    BooksInnerModel temp;
    String date = DateTime.now().toString().substring(0, 10);
    var index = amount! + 2;
    if (_1ticket > 0) {
      temp = BooksInnerModel(
          history: "$name 님 1회권 추가",
          cost: (_1ticket * 12000).toString(),
          date: date,
          index: index);
      await insertSheets(temp);
      index = index + 1;
    }
    if (_4ticket > 0) {
      temp = BooksInnerModel(
          history: "$name 님 4회권 추가",
          cost: (_4ticket * 40000).toString(),
          date: date,
          index: index);
      await insertSheets(temp);
      index = index + 1;
    }
    if (_1month > 0) {
      temp = BooksInnerModel(
          history: "$name 님 1개월 추가",
          cost: (_1month * 36000).toString(),
          date: date,
          index: index);
      await insertSheets(temp);
      index = index + 1;
    }
    if (_3month > 0) {
      temp = BooksInnerModel(
          history: "$name 님 3개월 추가",
          cost: (_3month * 96000).toString(),
          date: date,
          index: index);
      await insertSheets(temp);
      index = index + 1;
    }
  }
}
