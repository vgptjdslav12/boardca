import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/utils/books_sheets.dart';
import '../model/books_model.dart';

final booksProvider =
    StateNotifierProvider.autoDispose<MemberNotifier, BooksModelBase>((ref) {
  return MemberNotifier();
});

class MemberNotifier extends StateNotifier<BooksModel> {
  MemberNotifier() : super(BooksModel(num: 0, list: [])) {
    getBooks(1, bSheets);
  }

  void update(BooksModel model, BooksSheets sheets, int index, int num) {
    state = model;
    sheets.updateSheets(model, index, num);
  }

  Future<void> getBooks(int num, BooksSheets sheets) async {
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
