abstract class BooksModelBase {}

class BooksModelLoading extends BooksModelBase {}

class BooksModelError extends BooksModelBase {
  BooksModelError(this.message);
  final String message;
}

class BooksModel extends BooksModelBase {
  BooksModel({required this.num, required this.list});
  final int num;
  final List<BooksInnerModel> list;
}

class BooksInnerModel extends BooksModelBase {
  BooksInnerModel(
      {required this.history,
      required this.cost,
      required this.date,
      required this.index});
  final String history;
  final String cost;
  final String date;
  final int index;
}
