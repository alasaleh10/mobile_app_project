import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/adminpages/add_car.dart';
import 'package:mobile_app_project/adminpages/dsiplay_admin.dart';
import 'package:mobile_app_project/widgtes/continer.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';

class admin_home extends StatelessWidget {
  const admin_home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primecolore,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              titile: 'صفحة الادمن',
              size: 20,
              colors: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(add_car());
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primecolore,
                    backgroundImage: AssetImage('images/add.png'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(display_admin());
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primecolore,
                    backgroundImage: AssetImage('images/view.png'),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                text(
                  titile: 'اضافة سياره',
                  colors: Colors.white,
                ),
                text(
                  titile: 'استعراض جميع السيارات',
                  size: 17,
                  colors: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
