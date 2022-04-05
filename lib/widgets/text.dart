import 'package:flutter/material.dart';

class SimpleHeadline extends StatelessWidget {
  final String text;

  const SimpleHeadline({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      textAlign: TextAlign.start,
    );
  }
}
