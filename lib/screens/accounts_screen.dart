import 'package:flutter/material.dart';
import '../models/accounts_user_response.dart';
import 'account_item_screen.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({
    Key? key,
    required this.title,
    required this.element,
  }) : super(key: key);
  final List<AccountElement> element;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 50),
              Container(
                margin: EdgeInsets.zero,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: element.length,
                  itemBuilder: (context, index) {
                    return CardAccount(
                        subtitle: title,
                        current: '${element[index].account.amount}',
                        id: element[index].account.id);
                  },
                ),
              )
            ],
          )),
    ));
  }
}

class CardAccount extends StatelessWidget {
  final String id;
  final String current;
  final String subtitle;
  const CardAccount({
    Key? key,
    required this.id,
    required this.current,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            transitionsBuilder:
                (((context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            })),
            pageBuilder: (context, _, __) => AccountItemcreen(
                  title: 'Cuenta Corriente',
                  id: id,
                  current: current,
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(241, 142, 172, 1).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cuenta Nº :',
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400)),
              Text(id,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo :',
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400)),
              Text(current,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800))
            ],
          )
        ]),
      ),
    );
  }
}
