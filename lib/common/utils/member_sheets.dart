import 'dart:ffi';

import 'package:boardca/common/const/gsheetsconfig.dart';
import 'package:boardca/model/member_model.dart';
import 'package:gsheets/gsheets.dart';

final mSheets = MemberSheets();

class MemberSheets {
  final String _workSheetTitle = "members";
  Spreadsheet? spreadSheet;
  Worksheet? workSheet;

  Future<void> initalWorksheet() async {
    final gSheets = GSheetsconfig.gSheets;
    spreadSheet ??= await gSheets.spreadsheet(GSheetsconfig.spreadSheetId);
    workSheet = spreadSheet!.worksheetByTitle(_workSheetTitle);
  }

  Future<MemberModel> getSheets(int num) async {
    MemberModel model = MemberModel(num: num, list: []);
    var index;
    for (var i = 0; i < 10; i++) {
      index = 2 + i + ((num - 1) * 10);
      var str = await workSheet!.values.row(index);
      if (str != []) {
        var temp = MemberInnerModel(
            name: str[0],
            phone: str[1],
            ticket: str[2],
            date: str[3],
            index: index);
        model.list.add(temp);
      }
    }
    return model;
  }

  Future<void> updateSheets(int num, int index, MemberInnerModel values) async {
    var row = 2 + index + ((num - 1) * 10);
    var list = [values.name, values.phone, values.ticket, values.date];
    await workSheet!.values.insertRow(index, list);
  }
}
