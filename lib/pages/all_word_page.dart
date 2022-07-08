// ignore_for_file: prefer_const_constructors

/*
  hiển thị tất cả các danh sách từ còn 
*/ 
import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo_app_tienganh/models/english_today.dart';
import 'package:demo_app_tienganh/values/app_assets.dart';
import 'package:demo_app_tienganh/values/app_colors.dart';
import 'package:demo_app_tienganh/values/app_styles.dart';
import 'package:flutter/material.dart';

class AllWordPage extends StatelessWidget {

  final List<EnglishToday> words;

  const AllWordPage({ Key? key,required this.words }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.secondColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0,
          title: Text(
            'English today',
            style:
                AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppAssets.leftArrow),
          ),
        ),
      body: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: (index % 2) == 0
                        ? AppColors.primarycolor
                        : AppColors.secondColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    words[index].noun!,
                    style: (index % 2) == 0
                        ? AppStyle.h4
                        : AppStyle.h4.copyWith(color: AppColors.textColor),
                  ),
                  subtitle: Text(words[index].quote ??
                      '"Think of all the beauty still left around you and be happy"'),
                  leading: Icon(
                    Icons.favorite,
                    color: words[index].isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              );
            }),
    );
  }
}