import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../blocs/auth/auth_bloc.dart';
import '../theme/custom/custom.dart';
import '../widgets/custom_bottom.dart';
import '../widgets/custom_input.dart';
import '../widgets/decoration_widget.dart';
import '../widgets/label.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        child: Stack(children: [
          Container(
            decoration: boxDecoration,
          ),
          Positioned(top: -100, left: -30, child: DecorationWidget()),
          Positioned(top: 350, left: 20, right: 20, child: _Form()),
          Positioned(
              top: 10,
              right: 0,
              child: Container(
                margin: EdgeInsets.zero,
                width: 300,
                height: 300,
                child: Lottie.asset('assets/banking.json'),
              )),
        ]),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20)),
      height: 380,
      width: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomInput(
              icon: Icons.email_outlined,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl),
          CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Password',
              isPassword: true,
              textController: passCtrl),
          const Labels(
            title: 'Crear Cuenta Ahora!',
            route: 'register',
            subTitle: 'No tienes una cuenta?',
          ),
          const SizedBox(height: 10),
          const Text(
            'Terminos y condiciones de Uso ',
            style: TextStyle(fontWeight: FontWeight.w200, color: Colors.white),
          ),
          const SizedBox(height: 20),
          BottomRed(
              text: 'Login',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final loginOk = await authBloc.login(
                    emailCtrl.text.trim(), passCtrl.text.trim());
                if (loginOk) {
                  print('login success');
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: '¡Error!',
                      message: 'Usuario o contraseña son incorrectas',
                      contentType: ContentType.failure,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              })
        ]),
      ),
    );
  }
}