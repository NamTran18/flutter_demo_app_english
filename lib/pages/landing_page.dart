import 'package:demo_app_tienganh/pages/home_page.dart';
import 'package:demo_app_tienganh/values/app_assets.dart';
import 'package:demo_app_tienganh/values/app_colors.dart';
import 'package:demo_app_tienganh/values/app_styles.dart';
import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * trang đầu
 */

class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16), // padding kiểu đối xứng
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Wellcome to', style: AppStyle.h3,),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // làm cho view text to ra
                  children: [
                    Text(
                      'English',
                    style: AppStyle.h2.copyWith(
                      color: AppColors.blackgray,
                      fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        'Qoutes',
                        textAlign: TextAlign.right, // di chuyển view sang  bên phải
                        style: AppStyle.h4.copyWith(height: 0.5),),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: RawMaterialButton( 
                  fillColor: AppColors.lighBlue, // đổ màu cho button
                  shape: CircleBorder(), // tạo ra hình tròn cho button
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (route) => false); // click để chuyển sang trag home page và làm mất mũi tên trở lại trang chính
                  },
                  child: Image.asset(AppAssets.rightArrow),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

