import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/authpages/login.dart';
import 'package:mobile_app_project/main.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';

import 'package:mobile_app_project/profile_pages/about_app.dart';
import 'package:mobile_app_project/profile_pages/about_us.dart';
import 'package:mobile_app_project/profile_pages/account_setting.dart';
import 'package:mobile_app_project/widgtes/listtile.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget with curd {
  profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with curd {
  display() async {
    var response = await postRequst(
        display_accountserver, {'id': sharedPref.getInt('id').toString()});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
            child: FutureBuilder(
          future: display(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                color: prime_contenercolor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          color: primecolore,
                        ),
                        height: 200,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text(
                                            titile:
                                                '${snapshot.data['data']['name']}',
                                            size: 20,
                                            colors: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.person),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          text(
                                            titile:
                                                '${snapshot.data['data']['email']}',
                                            size: 16,
                                            colors: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.email),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        child: Image.network(
                                            '$usersimage/${snapshot.data['data']['user_image']}'),
                                      ),
                                      radius: 50,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      listtile(
                        ontap: () {
                          Get.to(account_settings());
                        },
                        title: 'اعدادات الحساب',
                        TR_icon: Icons.settings,
                      ),
                      listtile(
                        TR_icon: Icons.dark_mode,
                        title: 'تغيير الوضع المظلم',
                        ontap: () {
                          if (Get.isDarkMode == true) {
                            setState(() {});
                            Get.changeTheme(ThemeData.dark());
                          } else {
                            Get.changeTheme(ThemeData.light());
                          }
                        },
                      ),
                      listtile(
                        TR_icon: Icons.info,
                        title: 'عن التطبيق',
                        ontap: () {
                          Get.to(about_app());
                        },
                      ),
                      listtile(
                        TR_icon: Icons.people,
                        title: 'من نحن',
                        ontap: () {
                          Get.to(about_us());
                        },
                      ),
                      listtile(
                        TR_icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        ontap: () {
                          sharedPref.clear();
                          Get.offAll(login());
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    text(titile: 'جاري تحميل البيانات')
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )),
      ),
      onWillPop: (() async {
          return await Get.defaultDialog(
            textCancel: 'لا',
            textConfirm: 'نعم',
            onConfirm: (() {
              exit(0);
            }),
            onCancel: () {
              Navigator.pop(context);
            },
          );
        })
    );
  }
}
