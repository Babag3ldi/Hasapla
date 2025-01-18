import 'package:flutter/material.dart';

import '../common/color_constants.dart';

class ButtonConst extends StatelessWidget {
  const ButtonConst({
    required this.sizeHeight,
    required this.sizeWidth,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final double sizeHeight;
  final double sizeWidth;
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadowColor: Colors.lightBlue,
            minimumSize: Size(sizeWidth * 92, sizeHeight * 6)),
        onPressed: onPressed,
      
        child: Text(
          'Text here',
          style: TextStyle(fontSize: 14, color: Colors.white,),
        ));
  }
}
