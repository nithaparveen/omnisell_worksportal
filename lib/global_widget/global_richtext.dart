import 'package:flutter/material.dart';

class GLRichText extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;

  const GLRichText({
    super.key,
    required this.label,
    required this.value,
    required this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: fontSize,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
