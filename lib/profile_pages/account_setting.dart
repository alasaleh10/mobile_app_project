import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/authpages/login.dart';
import 'package:mobile_app_project/main.dart';

import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/viewpages/home.dart';

import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:mobile_app_project/widgtes/textform.dart';

import '../model/links.dart';

class account_settings extends StatefulWidget {
  account_settings({super.key});

  @override
  State<account_settings> createState() => _account_settingsState();
}

class _account_settingsState extends State<account_settings> with curd {
  displayprofile() async {
    var response = await postRequst(
        display_accountserver, {'id': sharedPref.getInt('id').toString()});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prime_contenercolor,
      body: SafeArea(
        child: Stack(children: [
          FutureBuilder(
              future: displayprofile(),
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(
                        titile: ' الملف الشخصي',
                        size: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          child: Image.network(
                              '$usersimage/${snapshot.data['data']['user_image']}'),
                        ),
                        radius: 50,
                      ),
                      Textformfiled(
                          suffixicone: Icons.person,
                          lable_text: '${snapshot.data['data']['name']}',
                          obsc: false),
                      Textformfiled(
                          enable: false,
                          suffixicone: Icons.email,
                          lable_text: '${snapshot.data['data']['email']}',
                          obsc: false),
                      Textformfiled(
                        enable: false,
                        lable_text: '${snapshot.data['data']['username']}',
                        obsc: false,
                        suffixicone: Icons.email_sharp,
                      ),
                      Textformfiled(
                        enable: false,
                        lable_text: '${snapshot.data['data']['phone']}',
                        obsc: false,
                        suffixicone: Icons.phone_android,
                      ),
                      Textformfiled(
                        enable: false,
                        lable_text: '${snapshot.data['data']['password']}',
                        obsc: false,
                        suffixicone: Icons.password,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: (() {
                              AwesomeDialog(
                                  dismissOnTouchOutside: false,
                                  showCloseIcon: true,
                                  dialogBackgroundColor: prime_contenercolor,
                                  context: context,
                                  dialogType: DialogType.error,
                                  btnOkOnPress: () async {
                                    var response = await postRequst(
                                        deleteaccoundserver, {
                                      'id': sharedPref.getInt('id').toString()
                                    });
                                    if (response['status'] == 'sucss') {
                                      Get.offAll(login());
                                    }
                                    return response;
                                  },
                                  btnOkText: 'حذف',
                                  btnOkColor: Colors.red,
                                  btnCancelText: 'الغاء',
                                  body: Column(
                                    children: [
                                      text(
                                          titile:
                                              'عند حذف الحساب سوف تفقد جميع بياناتك'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      text(
                                          titile: "!هل تريد حذف حسابك بالفعل؟"),
                                    ],
                                  )).show();
                            }),
                            child: Row(children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              text(
                                titile: '!حذف الحساب',
                                colors: Colors.red,
                              )
                            ]),
                          ),
                          MaterialButton(
                            onPressed: (() {}),
                            child: Row(children: [
                              Icon(Icons.edit),
                              text(titile: 'تعديل')
                            ]),
                          ),
                        ],
                      )
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.black,
                          ),
                          text(titile: '..جاري تحميل البيانات')
                        ]),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(titile: 'الرجاء التاكد من اتصال الانترنت'),
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: text(
                          titile: 'انقر للتاكد من وجود الانترنت',
                          colors: Colors.blue,
                        ),
                      )
                    ],
                  ),
                );
              })),
          Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: primecolore,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )))
        ]),
      ),
    );
  }
}
