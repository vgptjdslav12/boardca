abstract class MemberModelBase {}

class MemberModelLoading extends MemberModelBase {}

class MemberModelError extends MemberModelBase {
  MemberModelError(this.message);
  final String message;
}

class MemberModel extends MemberModelBase {
  MemberModel({required this.num, required this.list});
  final int num;
  final List<MemberInnerModel> list;
}

class MemberInnerModel extends MemberModelBase {
  MemberInnerModel(
      {required this.name,
      required this.phone,
      required this.ticket,
      required this.date,
      required this.index});
  final String name;
  final String phone;
  final String ticket;
  final String date;
  final int index;
}
