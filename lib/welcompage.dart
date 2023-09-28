import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/authpages/login.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';

class welcompage extends StatelessWidget {
  const welcompage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: 700,
            width: double.infinity,
            color: prime_contenercolor,
            child: Image.asset(
              'images/home_image.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              left: 120,
              top: 340,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                  onPressed: (() {
                    Get.offAll(login());
                  }),
                  child: text(
                    titile: 'لنبدأ',
                    size: 17,
                    weight: FontWeight.bold,
                    colors: Colors.black,
                  )))
        ],
      )),
    );
  }
}
