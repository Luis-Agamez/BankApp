import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String title;
  final String subTitle;
  const Labels(
      {Key? key,
      required this.route,
      required this.title,
      required this.subTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          subTitle,
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            title,
            style: const TextStyle(
              letterSpacing: 1,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(236, 98, 188, 1),
            ),
          ),
        )
      ],
    ));
  }
}
