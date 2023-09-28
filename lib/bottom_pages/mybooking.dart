import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/main.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/viewpages/booking.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:mobile_app_project/model/links.dart';

class mybooking extends StatefulWidget {
  const mybooking({super.key});

  @override
  State<mybooking> createState() => _mybookingState();
}

class _mybookingState extends State<mybooking> with curd {
  display_mybooking() async {
    var response = await postRequst(
        diplaybookingserver, {'id': sharedPref.getInt('id').toString()});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: SafeArea(
              child: FutureBuilder(
                  future: display_mybooking(),
                  builder: ((BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'filed') {
                        return Center(
                          child: text(titile: 'لايوجد حجوزات'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primecolore,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      text(
                                        titile:
                                            '${snapshot.data['data'][i]['name']}',
                                        size: 20,
                                        colors: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      text(
                                        titile:
                                            'ايام الحجز ${snapshot.data['data'][i]['days']}',
                                        colors: Colors.white,
                                        size: 20,
                                      ),
                                      text(
                                        titile:
                                            '${snapshot.data['data'][i]['car_price']}ر.ي',
                                        colors: Colors.white,
                                        size: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text(
                                            titile:
                                                '${snapshot.data['data'][i]['car_name']}',
                                            colors: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          // text(titile: '${}'),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                      height: 180,
                                      width: 200,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                            '$carsimages/${snapshot.data['data'][i]['car_image']}'),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
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
                            text(titile: '....جاري تحميل البيانات')
                          ],
                        ),
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
                  })))),
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
