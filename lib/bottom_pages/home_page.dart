import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';

import 'package:mobile_app_project/viewpages/booking.dart';
import 'package:mobile_app_project/viewpages/daipaly_rentals.dart';

import 'package:mobile_app_project/widgtes/continer.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../viewpages/display_car.dart';

class homepage extends StatefulWidget {
  // homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with curd {
  avaliblecar() async {
    var respons = await postRequst(
        avalibalcars, {'avialble': 1.toString(), 'rental': rentel});

    return respons;
  }

  late String cars;
  //final String ca;
  var _newrent = '';
  var rentel = 'تويوتا';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: prime_contenercolor,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: primecolore,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        text(
                          titile:
                              ' احجز سيارتك الان بخطوات بسيطة وسريعه  من خلال تطبيق  لتاجير السيارات',
                          colors: Colors.white,
                          size: 20,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      text(
                        titile: ' الماركات المتاحه',
                        colors: Colors.black,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return display_rentals(
                            rental: 'AUDI',
                          );
                        })));
                      },
                      child: continer(
                        imagename: 'images/audi.png',
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return display_rentals(
                              rental: 'TOYOTA',
                            );
                          })));
                        },
                        child: continer(imagename: 'images/toyota.png')),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return display_rentals(
                              rental: 'BMW',
                            );
                          })));
                        },
                        child: continer(imagename: 'images/BMW.svg.png')),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: text(
                          titile: 'الكل',
                          colors: Colors.blue,
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      ),
                      text(
                        titile: 'المتاحه',
                        colors: Colors.black,
                        size: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: avaliblecar(),
                    builder: ((BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['status'] == 'filed') {
                          return Center(
                            child: text(titile: 'لاتوجد سيارات متاحة'),
                          );
                        }
                        return CarouselSlider.builder(
                          options: CarouselOptions(height: 200),
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              InkWell(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return booking(
                                    car_name: snapshot.data['data'][itemIndex]
                                        ['car_name'],
                                    car_id: snapshot.data['data'][itemIndex]
                                        ['car_id'],
                                    car_dis: snapshot.data['data'][itemIndex]
                                        ['car_discription'],
                                    car_price: snapshot.data['data'][itemIndex]
                                        ['car_price'],
                                    car_image: snapshot.data['data'][itemIndex]
                                        ['car_image'],
                                  );
                                })));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        child: snapshot.data['data'][itemIndex]
                                                    ['car_image'] ==
                                                null
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Image.network(
                                                '$carsimages/${snapshot.data['data'][itemIndex]['car_image']}',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                      ),
                                      Column(
                                        children: [
                                          text(
                                            titile:
                                                '${snapshot.data['data'][itemIndex]['car_name']}',
                                            size: 20,
                                            colors: Colors.black,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            text(
                                              titile:
                                                  '${snapshot.data['data'][itemIndex]['car_price']}ر.ي',
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            text(
                                              titile:
                                                  '${snapshot.data['data'][itemIndex]['car_discription']}',
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(249, 249, 249, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
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
                      );
                    }))
              ],
            ),
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
        }));
  }
}
