import 'package:flutter/material.dart';

// define phông chữ
class FontFamily{

  static const sen = 'Sen';
}

class AppStyle{

  // ignore: prefer_const_constructors
  static TextStyle h1 = TextStyle(fontFamily: FontFamily.sen,fontSize: 109.66,color: Colors.white);
  // ignore: prefer_const_constructors
  static TextStyle h2 = TextStyle(fontFamily: FontFamily.sen,fontSize: 66.77,color: Colors.white);
  // ignore: prefer_const_constructors
   static TextStyle h3 = TextStyle(fontFamily: FontFamily.sen, fontSize: 41.89, color: Colors.white);
      // ignore: prefer_const_constructors
  static TextStyle h4 = TextStyle(fontFamily: FontFamily.sen, fontSize: 25.89, color: Colors.white);
      // ignore: prefer_const_constructors
  static TextStyle h5 =TextStyle(fontFamily: FontFamily.sen, fontSize: 16, color: Colors.white);
      // ignore: prefer_const_constructors
  static TextStyle h6 = TextStyle(fontFamily: FontFamily.sen, fontSize: 9.89, color: Colors.white);

}