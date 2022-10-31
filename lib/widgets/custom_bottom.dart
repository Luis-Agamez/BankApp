import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomRed extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const BottomRed({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      hoverElevation: 5,
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(236, 98, 188, 1),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              letterSpacing: 2,
              fontFamily: 'Lobster'),
        )),
      ),
    );
  }
}
