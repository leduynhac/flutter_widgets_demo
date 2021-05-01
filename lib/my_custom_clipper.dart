import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
      return Rect.fromLTWH(0, 0, 200, 100);
    }
  
    @override
    bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
      return true;
  }

  
}