import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/adminpages/add_car.dart';
import 'package:mobile_app_project/adminpages/admin_home.dart';
import 'package:mobile_app_project/adminpages/admin_log.dart';
import 'package:mobile_app_project/adminpages/dsiplay_admin.dart';
import 'package:mobile_app_project/adminpages/editcar.dart';
import 'package:mobile_app_project/authpages/login.dart';
import 'package:mobile_app_project/authpages/signup.dart';

import 'package:mobile_app_project/profile_pages/account_setting.dart';
import 'package:mobile_app_project/splash_screen.dart';
import 'package:mobile_app_project/test.dart';
import 'package:mobile_app_project/viewpages/booking.dart';
import 'package:mobile_app_project/viewpages/daipaly_rentals.dart';

import 'package:mobile_app_project/viewpages/display_car.dart';
import 'package:mobile_app_project/viewpages/home.dart';
import 'package:mobile_app_project/bottom_pages/home_page.dart';
import 'package:mobile_app_project/bottom_pages/mybooking.dart';
import 'package:mobile_app_project/welcompage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp( car_rentel(),);
}

class car_rentel extends StatelessWidget {
  const car_rentel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      //splaash_screen()
      
     sharedPref.getInt('id')==null?login():home(),
    );
  }
}
