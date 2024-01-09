import 'package:flutter/material.dart';

class CustomFont extends StatelessWidget{
  const CustomFont({super.key,required this.data, this.size= 16, this.fweight=FontWeight.normal});

  final double size;
  final String data;
  final FontWeight fweight;

  @override
  Widget build(BuildContext context) {
    return(
      Text(data, style: TextStyle(fontSize: size, fontWeight: fweight),)
    );
  }
}