import 'dart:ffi';

import 'package:boardca/common/const/gsheetsconfig.dart';
import 'package:boardca/model/member_model.dart';
import 'package:gsheets/gsheets.dart';

final sSheets = SettingSheets();

class SettingSheets {
  final String _workSheetTitle = "members";
  Spreadsheet? spreadSheet;
  Worksheet? workSheet;
  int? amount;

  Future<void> initalWorksheet() async {
    final gSheets = GSheetsconfig.gSheets;
    spreadSheet ??= await gSheets.spreadsheet(GSheetsconfig.spreadSheetId);
    workSheet = spreadSheet!.worksheetByTitle(_workSheetTitle);
    amount = int.parse(await workSheet!.values.value(column: 7, row: 1));
  }

  Future<MemberModel> getSheets(int num) async {
    MemberModel model = MemberModel(num: num, list: []);
    var index = 2 + ((num - 1) * 10);
    var t = 0;
    var list = await workSheet!.values.allRows(fromRow: index, count: 10);
    for (var i in list) {
      var temp = MemberInnerModel(
          name: i[0],
          phone: i[1],
          ticket: i[2],
          date: i[3],
          index: index + t++);
      model.list.add(temp);
    }
    return model;
  }

  Future<void> updateSheets(MemberModel model, int index, int num) async {
    var list = [
      model.list[index].name,
      model.list[index].phone,
      model.list[index].ticket,
      model.list[index].date
    ];
    await workSheet!.values.insertRow(index + ((num - 1) * 10) + 1, list);
  }

  Future<void> insertSheets(MemberInnerModel model) async {
    var index = 2 + amount!;

    await workSheet!.values.insertRow(index++, [
      model.name,
      model.phone,
      model.ticket,
      model.date,
    ]);
    amount = int.parse(await workSheet!.values.value(column: 7, row: 1));
  }

  Future<void> serachSheets(String name) async {
    print(await workSheet!.values.rowByKey(name));
  }
}
