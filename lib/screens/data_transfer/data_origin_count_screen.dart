import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import 'data_send_account_screen.dart';

class DataOriginCountScreen extends StatelessWidget {
  final String value;
  final String money;

  const DataOriginCountScreen(
      {Key? key, required this.value, required this.money})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const SizedBox(height: 50),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.zero,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.saving.length,
                          itemBuilder: (context, index) {
                            return state.saving.isNotEmpty
                                ? CardAccount(
                                    account: "saving",
                                    money: money,
                                    value: value,
                                    current:
                                        '${state.saving[index].account.amount}',
                                    id: state.saving[index].account.id)
                                : Container();
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.zero,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.stream.length,
                          itemBuilder: (context, index) {
                            return state.stream.isNotEmpty
                                ? CardAccount(
                                    account: "stream",
                                    money: money,
                                    value: value,
                                    current:
                                        '${state.stream[index].account.amount}',
                                    id: state.stream[index].account.id)
                                : Container();
                          },
                        ),
                      );
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CardAccount extends StatelessWidget {
  final String id;
  final String current;
  final String money;
  final String value;
  final String account;
  const CardAccount({
    Key? key,
    required this.id,
    required this.current,
    required this.money,
    required this.value,
    required this.account,
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
            pageBuilder: (context, _, __) => DataSendAccountScreen(
                  account: account,
                  idOrigin: id,
                  money: money,
                  value: value,
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
