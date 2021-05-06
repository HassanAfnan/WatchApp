import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  const TitleText(
    this.text, {
    Key key,
    this.fontSize = 18,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w800,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.muli(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
