import 'package:flutter/material.dart';
import '../utils/images.dart';

Widget AppLogo() {
  return Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Center(
      child: Image.asset(AssetImages.appLogo,
      height: 250, width: 250,),
    ),
  );
}