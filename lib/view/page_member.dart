import 'dart:ffi';

import 'package:boardca/common/const/font.dart';
import 'package:flutter/material.dart';
import 'package:boardca/layout/default_layout.dart';
import 'package:boardca/layout/menu_drawer.dart';
import 'package:boardca/common/utils/member_sheets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/const/colors.dart';
import '../model/member_model.dart';
import '../provider/member_provider.dart';

class MemberPage extends ConsumerStatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends ConsumerState<MemberPage> {
  final String title = '회원 관리';
  var num = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var memberList = ref.watch(memberProvider) as MemberModel;
    return DefaultLayout(
      title: title,
      drawer: menu_drawer(),
      appBar: appBar(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 20),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text("이름 / 전화번호",
                  style: TextStyle(
                      fontSize: LARGE_FONT_SIZE, fontWeight: FontWeight.bold)),
              trailing: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      flex: 6,
                      child: Text("1 회권",
                          style: TextStyle(
                              fontSize: DEFUALT_FONT_SIZE,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right),
                    ),
                    Expanded(flex: 4, child: SizedBox()),
                    Expanded(
                      flex: 9,
                      child: Text("갱신일",
                          style: TextStyle(
                              fontSize: DEFUALT_FONT_SIZE,
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
            if (memberList.list.isNotEmpty) ...[
              for (var i in memberList.list) ...[
                Expanded(
                  flex: 1,
                  child: tile(i),
                )
              ]
            ] else ...[
              const CircularProgressIndicator(),
              const Text('로딩중입니다...'),
            ],
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

  ListTile tile(MemberInnerModel list) {
    return ListTile(
      onTap: () => {
        setState(() => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => memberDialog(list)))
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(list.name,
          style: const TextStyle(
              fontSize: LARGE_FONT_SIZE, fontWeight: FontWeight.bold)),
      subtitle: Text(list.phone,
          style: const TextStyle(
              fontSize: DEFUALT_FONT_SIZE - 1, fontWeight: FontWeight.bold)),
      trailing: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: FittedBox(
                alignment: Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text("${list.ticket} 회",
                    style: const TextStyle(
                        fontSize: DEFUALT_FONT_SIZE,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
              ),
            ),
            const Expanded(flex: 4, child: SizedBox()),
            Expanded(
              flex: 9,
              child: FittedBox(
                alignment: Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text(list.date,
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
          onPressed: () => {}, // dialog
        ),
      ],
      title: Text(
        title,
        style:
            const TextStyle(color: BUTTON_COLOR, fontWeight: FontWeight.bold),
      ),
    );
  }

  Dialog memberDialog(MemberInnerModel list) {
    var _ticket = int.parse(list.ticket);
    var _date = list.date;
    var _temp;
    return Dialog(child: StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "이름",
                          style: TextStyle(
                              fontSize: DIALOG_FONT_SIZE,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          list.name,
                          style: const TextStyle(
                              fontSize: DIALOG_FONT_SIZE,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ))
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "전화번호",
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
                              list.phone,
                              style: const TextStyle(
                                  fontSize: DIALOG_FONT_SIZE,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )))
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "1 회권",
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
                              "$_ticket  회",
                              style: const TextStyle(
                                  fontSize: DIALOG_FONT_SIZE,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 28,
                              child: ElevatedButton(
                                  onPressed: () =>
                                      {setState(() => _ticket += -1)},
                                  child: const Text("사용",
                                      style: TextStyle(
                                          fontSize: DEFUALT_FONT_SIZE))),
                            ),
                            const SizedBox(),
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
                        "갱신일",
                        style: TextStyle(
                            fontSize: DIALOG_FONT_SIZE,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Text(
                          _date,
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("1 회권",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => {setState(() => _ticket += 1)},
                        child: const Text("1 회권"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => {setState(() => _ticket += 4)},
                        child: const Text("4 회권"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("1 달제",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(() => _date = DateTime.parse(_date)
                              .add(const Duration(days: 30))
                              .toString()
                              .substring(0, 10))
                        },
                        child: const Text("1 달"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(() => _date = DateTime.parse(_date)
                              .add(const Duration(days: 90))
                              .toString()
                              .substring(0, 10))
                        },
                        child: const Text("3 달"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => {
                          list = MemberInnerModel(
                              name: list.name,
                              phone: list.phone,
                              ticket: _ticket.toString(),
                              date: _date,
                              index: list.index),
                          _temp = ref.read(memberProvider),
                          _temp.list[list.index - 2] = list,
                          this.setState(() {
                            setState(() {
                              ref.read(memberProvider.notifier).update(_temp);
                            });
                          }),
                          Navigator.pop(context)
                        },
                        child: const Text("확인"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: const Text("취소"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
