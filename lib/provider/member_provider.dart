import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/utils/member_sheets.dart';
import '../model/member_model.dart';

final memberProvider =
    StateNotifierProvider.autoDispose<MemberNotifier, MemberModelBase>((ref) {
  return MemberNotifier();
});

class MemberNotifier extends StateNotifier<MemberModel> {
  MemberNotifier() : super(MemberModel(num: 0, list: [])) {
    getMember(1, mSheets);
  }

  void update(MemberModel model, MemberSheets sheets, int index, int num) {
    state = model;
    sheets.updateSheets(model, index, num);
  }

  Future<void> getMember(int num, MemberSheets sheets) async {
    try {
      final resp = await sheets.getSheets(num);
      state = resp;
      print(state);
    } catch (e) {
      print(e);
      return;
    }
  }
}
