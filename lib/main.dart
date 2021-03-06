import 'package:demo_app_tienganh/packages/quote/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/landing_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch:  Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

