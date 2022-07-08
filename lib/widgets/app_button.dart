
// ignore_for_file: prefer_const_constructors

import 'package:demo_app_tienganh/values/app_colors.dart';
import 'package:demo_app_tienganh/values/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String label;
  final VoidCallback onTap; // gọi để giao tiếp với function

  const AppButton({ Key? key, required this.label,required this.onTap }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (() {
        onTap();
      }),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 14),
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: Colors.white,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.black26,offset:Offset(3,6),blurRadius: 6
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Text(
            label,
            style: AppStyle.h5.copyWith(color: AppColors.textColor),
          ),
      ),
    );
  }
}