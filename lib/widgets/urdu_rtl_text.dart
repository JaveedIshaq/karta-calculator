import 'package:flutter/material.dart';

class UrduRTLText extends StatelessWidget {
  const UrduRTLText({
    super.key,
    required this.text,
    this.fontSize = 30,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Jameel Noori Nastaleeq',
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
