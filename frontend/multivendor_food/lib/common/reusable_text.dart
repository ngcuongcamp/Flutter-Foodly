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

class ReusableTextBackground extends StatelessWidget {
  const ReusableTextBackground({
    super.key,
    required this.text,
    required this.style,
    this.isCenter,
  });

  final String text;
  final TextStyle style;
  final bool? isCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromRGBO(128, 128, 128, 0.7),
        border: Border.all(color: Colors.white, width: 0.5), // đổi màu nếu muốn
      ),
      child: Text(
        text,
        maxLines: 3,
        softWrap: true,
        textAlign: (isCenter ?? false) ? TextAlign.center : TextAlign.left,
        style: style,
      ),
    );
  }
}
