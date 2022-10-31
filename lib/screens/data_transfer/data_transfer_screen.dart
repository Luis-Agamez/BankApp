import 'package:flutter/material.dart';

import '../../widgets/data_input.dart';
import '../../widgets/widgets.dart';
import 'data_origin_count_screen.dart';

class DataTransferScreen extends StatelessWidget {
  const DataTransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = TextEditingController(text: '');
    String text = "COP";
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            const SizedBox(height: 100),
            Form(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  DataInput(
                    textController: value,
                    minimum: 1,
                    placeholder: 'Ingrese la cantidad',
                    subTitle: 'Valor',
                    type: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonFormField<String>(
                      value: 'COP',
                      items: const [
                        DropdownMenuItem(child: Text('US'), value: 'US'),
                        DropdownMenuItem(child: Text('COP'), value: 'COP'),
                      ],
                      onChanged: (value) {
                        text = value ?? 'COP';
                      },
                    ),
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
                              DataOriginCountScreen(
                                money: text,
                                value: value.text.trim(),
                              )));
                    },
                    text: 'Siguiente',
                  )
                ],
              ),
            ))
          ],
        ),
        Positioned(bottom: -300, left: -80, child: DecorationWidget())
      ],
    ));
  }
}
