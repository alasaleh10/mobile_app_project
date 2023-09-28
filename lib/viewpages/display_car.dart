import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/viewpages/booking.dart';
import 'package:mobile_app_project/viewpages/home.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';

import '../widgtes/text.dart';

class displaycar extends StatelessWidget {
  const displaycar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: prime_contenercolor,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    'images/h8.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
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
                            color: Colors.black,
                          ),
                        )))
              ],
            ),
            Column(
              children: [
                text(
                  titile: 'TOYOTA',
                  colors: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.heart_broken_sharp,
                      color: primecolore,
                      size: 40,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(titile: '4.5'),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  trailing: CircleAvatar(),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: text(titile: 'علاء'),
                  ),
                  subtitle: Align(
                      alignment: Alignment.bottomRight,
                      child: text(
                        titile: 'المكلا',
                      )),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (() {}), icon: Icon(Icons.message)),
                      IconButton(onPressed: (() {}), icon: Icon(Icons.phone))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: text(
                      titile: 'مواصفات السياره',
                      colors: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: text(titile: 'titile')),
                  decoration: BoxDecoration(
                      color: primecolore,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 70,
                  width: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: primecolore),
                      onPressed: (() {
                      //  Get.to(booking());
                      }),
                      child: text(titile: 'حجز الان - 12300 ر.س')),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
