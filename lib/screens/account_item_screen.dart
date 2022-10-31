import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AccountItemcreen extends StatelessWidget {
  const AccountItemcreen(
      {Key? key, required this.title, required this.id, required this.current})
      : super(key: key);
  final String title;
  final String id;
  final String current;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BodyAccounts(title: title, id: id, current: current),
        Positioned(
          bottom: -100,
          left: -50,
          child: DecorationWidget(),
        )
      ],
    ));
  }
}
