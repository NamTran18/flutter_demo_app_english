

// ignore_for_file: non_constant_identifier_names

import 'package:demo_app_tienganh/values/app_assets.dart';
import 'package:demo_app_tienganh/values/app_colors.dart';
import 'package:demo_app_tienganh/values/app_styles.dart';
import 'package:demo_app_tienganh/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({ Key? key }) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {

 double sliderValue = 5; 
 late SharedPreferences prefs;

 @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
     prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'Your control',
          style:
              AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance(); // khoi tạo đối tượng của packet
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt()); // lưu giá trị nguyên vào  biến counter
            Navigator.pop(context); // quay về trang trước
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          Spacer(),
          Text(
          'How much a number word at one',
          style: AppStyle.h4.copyWith(
            color: AppColors.lightGrey,
            fontSize: 20,)
          ),
          Spacer(),
           Text(
            '${sliderValue.toInt()}', // lấy số kiểu int
          style: AppStyle.h1.copyWith(
            color: AppColors.primarycolor,
            fontSize: 150,
            fontWeight: FontWeight.bold)),
            Slider(value: sliderValue,min: 5,max: 100, // tạo ra thanh trượt 
            divisions: 95,              // xác định số lầm phân chia
            activeColor: AppColors.primarycolor,
            inactiveColor: AppColors.primarycolor,
            onChanged: (Value) {
              print(Value);
              setState(() {
                sliderValue = Value;
              });
            }), // tạo ra 1 cái thanh trượt
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
              'slide to set',
              style: AppStyle.h5.copyWith(
              color: AppColors.textColor,
              fontSize: 20,
              )),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
        ],
        ),
      ),
     );
  }
}