import 'package:flutter/material.dart';


class AppText extends StatelessWidget {
  
const AppText({ super.key, required this.text, required this.textStyle, this.maxLines, this.textAlign });

  final String text;
  final TextStyle textStyle;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context){
    
    return Text(text, textAlign: textAlign, style: textStyle.copyWith(letterSpacing: 1.0), maxLines: maxLines,);
  
  }
}