import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../blocs/auth/auth_bloc.dart';
import 'screens.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: chackLoginState(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Center(child: Lottie.asset('assets/bankinit.json'));
      },
    ));
  }

  Future chackLoginState(BuildContext context) async {
    late AuthBloc authBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);

    final autenticated = await authBloc.idLogggedIn();

    if (autenticated) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomeScreen(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: const Duration(milliseconds: 0)));
    }
  }
}
