import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_bottom.dart';
import '../../widgets/data_input.dart';
import '../qr_screen.dart';

class RegisterAccountScreen extends StatelessWidget {
  const RegisterAccountScreen(
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
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final data = TextEditingController(text: '');
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    DataInput(
                      textController: data,
                      minimum: 10,
                      placeholder: 'Ingrese el numero de la cuenta',
                      subTitle: 'Cuenta',
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    BottomRed(
                      onPressed: () async {
                        final token = await authBloc.createTokenQr(
                            idOrigin, data.text, value, money, "notregistered");

                        Navigator.of(context).push(PageRouteBuilder(
                            transitionsBuilder: (((context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            })),
                            pageBuilder: (context, _, __) => QrScreen(
                                  token: token,
                                )));
                      },
                      text: 'Siguiente',
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
