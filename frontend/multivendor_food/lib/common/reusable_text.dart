import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key, required this.text, required this.style, this.isCenter});

  final String text;
  final TextStyle style;
  final bool? isCenter;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      softWrap: true,
      textAlign: (isCenter != null) ? TextAlign.center : TextAlign.left,
      style: style,
    );
  }
}
