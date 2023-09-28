import 'package:flutter/material.dart';
import 'package:mobile_app_project/authpages/login.dart';
import 'package:mobile_app_project/bottom_pages/home_page.dart';
import 'package:mobile_app_project/bottom_pages/mybooking.dart';
import 'package:mobile_app_project/bottom_pages/profile.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int selectindex = 0;
  List pages = [homepage(), mybooking(), profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: prime_contenercolor,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
              currentIndex: selectindex,
              mouseCursor: MouseCursor.uncontrolled,
              landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
              enableFeedback: true,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedLabelStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              unselectedFontSize: 15,
              selectedItemColor: Colors.white,
              elevation: 30,
              iconSize: 20,
              backgroundColor: primecolore,
              onTap: (index) {
                setState(() {
                  selectindex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'الصفحه الرئيسية'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.car_crash), label: 'حجوزاتي'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'الملف الشخصي '),
              ]),
        ),
      ),
      body: pages.elementAt(selectindex),
    );
  }
}
