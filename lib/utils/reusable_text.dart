import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  double? size;
  Color? color;
  FontWeight? fontWeight;


   ReusableText({Key? key,required this.text, this.size,this.color,this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: size,color: color,fontWeight: fontWeight),);
  }
}
