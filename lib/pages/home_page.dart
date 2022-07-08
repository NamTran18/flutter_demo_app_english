// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:collection';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo_app_tienganh/models/english_today.dart';
import 'package:demo_app_tienganh/packages/quote/qoute_model.dart';
import 'package:demo_app_tienganh/packages/quote/quote.dart';
import 'package:demo_app_tienganh/pages/all_word_page.dart';
import 'package:demo_app_tienganh/pages/control_page.dart';
import 'package:demo_app_tienganh/values/app_assets.dart';
import 'package:demo_app_tienganh/values/app_colors.dart';
import 'package:demo_app_tienganh/values/app_styles.dart';
import 'package:demo_app_tienganh/values/share_keys.dart';
import 'package:demo_app_tienganh/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController; // đối tượng đẻ lấy thông tin  bên trong pageview

  List<EnglishToday> words = [];

  String quote = Quotes().getRandom().content!;

  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max); // giới hạn tối đa
      if (newList.contains(val)) {
        // kiểm tra
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    print('before await');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('after await');
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    //danh sách ramdom
    List<int> rans = fixedListRamdom(len: len, max: nouns.length);// nouns: là 1 danh sách có rất nhiều từ
    rans.forEach((index) {
      // duyệt tuần tự qua các phần tử trong danh sách
      newList.add(nouns[index]);
    });

    setState(() {
      // danh sách các câu trích dẫn 
      words = newList.map((e) => getQuote(e)).toList();// map() ánh xạ tất cả các phần tử của danh sách thành một biểu thức hoặc câu lệnh.
    });

    print('has data');
  }

  EnglishToday  getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // định danh

  @override
  void initState() {
    print('chạy vào đây ');
    _pageController = PageController(viewportFraction: 0.9); // hiển thị độ rộng của pageview (1.0 mối trang sẽ lắp đầy)
    super.initState();
    print('xuống đây');
    getEnglishToday();
    print('tiếp tục');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // tổng kích thước màn hình của homepage
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),
      body: Container(
        width: double.infinity, // chiếm toàn bộ chiều rộng
        child: Column(
          children: [
            Container(
                height: size.height * 1 / 10,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.centerLeft,
                child: Text(
                  '"$quote"',
                  style: AppStyle.h5.copyWith(
                    fontSize: 12,
                    color: AppColors.textColor,
                  ),
                )),
            Container(
              height: size.height * 2 / 3,
              child: PageView.builder( //  thanh cuộn các  view
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length > 5 ? 6 : words.length, // số các view
                  itemBuilder: (context, index) { 
                    String firstLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    firstLetter = firstLetter.substring(0, 1); // lấy chữ cái đầu 
                    // lấy các chữ cái còn lại
                    String leftLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    leftLetter = leftLetter.substring(1, leftLetter.length);

                    String quoteDefault =
                        "Think of all the beauty still left around you and be happy";

                    String qoute = words[index].quote != null
                        ? words[index].quote!
                        : quoteDefault;

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration( // trang trí
                          color: AppColors.primarycolor,
                          boxShadow: [ // đổ bóng 
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 6),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: index >= 5
                            ? InkWell(
                                onTap: () {
                                  print('show more...');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AllWordPage(words: words),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text('Show more...',
                                      style: AppStyle.h3.copyWith(shadows: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(3, 6),
                                            blurRadius: 6)
                                      ])),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LikeButton(
                                    onTap: (bool isLiked) async {
                                      setState(() {
                                        words[index].isFavorite =
                                            !words[index].isFavorite;
                                      });
                                      return words[index].isFavorite;
                                    },
                                    isLiked: words[index].isFavorite,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    size: 42,
                                    circleColor: CircleColor(
                                        start: Color(0xff00ddff),
                                        end: Color(0xff0099cc)),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return ImageIcon(
                                        AssetImage(AppAssets.heart),
                                        color:
                                            isLiked ? Colors.red : Colors.white,
                                        size: 42,
                                      );
                                    },
                                  ),
                                  RichText(
                                      maxLines: 1, // chỉ hiện trên 1 dòng
                                      overflow: TextOverflow.ellipsis, // các kiểu hiển thị khi chữ quá dài
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: firstLetter,
                                          style: TextStyle(
                                              fontFamily: FontFamily.sen,
                                              fontSize: 89,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(3, 6),
                                                    blurRadius: 6),
                                              ]),
                                          children: [
                                            TextSpan(
                                                text: leftLetter,
                                                style: TextStyle(
                                                    fontFamily: FontFamily.sen,
                                                    fontSize: 56,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      BoxShadow(
                                                          color: Colors.black38,
                                                          offset: Offset(3, 6), // độ đổ bóng
                                                          blurRadius: 6),
                                                    ])),
                                          ])),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: AutoSizeText(
                                      '"$qoute"',
                                      maxFontSize: 26,
                                      style: AppStyle.h4.copyWith(
                                          letterSpacing: 1,
                                          color: AppColors.textColor),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  }),
            ),

            //indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: size.height * 1 / 11,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  alignment: Alignment.center,
                  child: ListView.builder( // tạo ra các iteam để cuộn
                      physics: NeverScrollableScrollPhysics(),// làm cho thanh cuộn đứng yên
                      scrollDirection: Axis.horizontal, // cuộn theo chiều ngang
                      itemCount: 5,
                      itemBuilder: (context, index) { // hiển thị từng mục trong danh sách
                        return buildIndicator(index == _currentIndex, size);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primarycolor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),

      //tạo menu trượt bên trái
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text(
                  'Your mind',
                  style: AppStyle.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                    label: 'Favorites',
                    onTap: () {
                      print('Favorites');
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                    label: 'Your control',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ControlPage()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
  // define từng iteam của thanh cuộn ngang
  Widget buildIndicator(bool isActive, Size size) { 
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}
