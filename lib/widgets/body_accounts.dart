import 'package:flutter/material.dart';

class BodyAccounts extends StatelessWidget {
  const BodyAccounts({
    Key? key,
    required this.title,
    required this.id,
    required this.current,
  }) : super(key: key);
  final String title;
  final String id;
  final String current;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          Column(
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600)),
              const Text('Numero de cuenta',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300)),
              Text(id,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 130),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Saldo :',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(width: 10),
                  Text(current,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 50),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
