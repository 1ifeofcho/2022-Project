// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  LargeText({
    Key? key,
    required this.text,
    required this.color,
    this.size = 25,
  }) : super(key: key);
  double size;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
