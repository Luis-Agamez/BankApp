import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_bottom.dart';
import '../qr_screen.dart';
import 'register_account_screeen.dart';

class DataSendAccountScreen extends StatelessWidget {
  const DataSendAccountScreen(
      {Key? key,
      required this.value,
      required this.money,
      required this.idOrigin,
      required this.account})
      : super(key: key);
  final String value;
  final String money;
  final String idOrigin;
  final String account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Text('Ultimas Transsaciones ',
                      style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.zero,
                        child: SingleChildScrollView(
                          child: Container(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: state.accountsSavingRegistered.length,
                              itemBuilder: (context, index) {
                                return state.accountsSavingRegistered.isNotEmpty
                                    ? CardAccount(
                                        account: account,
                                        idOrigin: idOrigin,
                                        money: money,
                                        value: value,
                                        id: state
                                            .accountsSavingRegistered[index]
                                            .account[0],
                                      )
                                    : Container();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.zero,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: state.accountsStreamRegistered.length,
                            itemBuilder: (context, index) {
                              return state.accountsStreamRegistered.isNotEmpty
                                  ? CardAccount(
                                      account: account,
                                      idOrigin: idOrigin,
                                      money: money,
                                      value: value,
                                      id: '${state.accountsStreamRegistered[index].account[0]}',
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  BottomRed(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionsBuilder: (((context, animation,
                              secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          })),
                          pageBuilder: (context, _, __) =>
                              RegisterAccountScreen(
                                money: money,
                                account: account,
                                idOrigin: idOrigin,
                                value: value,
                              )));
                    },
                    text: 'Cuenta No Inscrita',
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
  final String value;
  final String money;
  final String idOrigin;
  final String account;
  const CardAccount({
    Key? key,
    required this.id,
    required this.value,
    required this.money,
    required this.idOrigin,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return InkWell(
      onTap: () async {
        final token =
            await authBloc.createTokenQr(idOrigin, id, value, money, account);

        Navigator.of(context).push(PageRouteBuilder(
            transitionsBuilder:
                (((context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            })),
            pageBuilder: (context, _, __) => QrScreen(
                  token: token,
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 201, 52, 96).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nº Cuenta :',
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
          )
        ]),
      ),
    );
  }
}
