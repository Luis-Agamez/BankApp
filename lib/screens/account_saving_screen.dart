import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AccountSavingScreen extends StatelessWidget {
  const AccountSavingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BodyAccounts(
            title: 'Cuenta Ahorros',
            id: '635dd5dbaf48cab353a6f274',
            current: '400000'),
        Positioned(
          bottom: 30,
          left: -50,
          child: DecorationWidget(),
        )
      ],
    ));
  }
}
