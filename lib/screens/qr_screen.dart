import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/custom_bottom.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key, required this.token}) : super(key: key);
  final String token;
  @override
  Widget build(BuildContext context) {
    print(token);
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Codigo Qr',
                style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
              QrImage(data: token),
              const SizedBox(height: 10),
              BottomRed(
                onPressed: () async {
                  Navigator.pushNamed(context, 'home');
                },
                text: 'Salir',
              )
            ],
          ),
        ),
      )),
    );
  }
}
