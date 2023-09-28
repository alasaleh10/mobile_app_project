import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/welcompage.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';

class splaash_screen extends StatelessWidget {
  const splaash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primecolore,
      child: EasySplashScreen(
        navigator: welcompage(),
        backgroundColor: primecolore,
        logo: Image.asset(
          'images/a.png',
          height: 200,
        ),
        loaderColor: Colors.white,

        // navigator: welcompage(),
      ),
    );
  }
}
