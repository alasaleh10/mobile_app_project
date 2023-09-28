import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';

import 'booking.dart';

class display_rentals extends StatefulWidget {
  final String rental;
  const display_rentals({super.key, required this.rental});

  @override
  State<display_rentals> createState() => _display_rentalsState();
}

class _display_rentalsState extends State<display_rentals> with curd {
  display_cars() async {
    var response =
        await postRequst(display_rentalsserver, {'rental': widget.rental});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: prime_contenercolor,
        body: Stack(children: [
          FutureBuilder(
              future: display_cars(),
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'filed') {
                    return Center(
                      child: text(titile: 'لاتوجد سيارات'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(13),
                        child: InkWell(
                          onTap: () {
                            if (snapshot.data['data'][index]['car_resev'] ==
                                1) {
                              Get.snackbar('تنبيه', "لايمكن حجز هذه السياره");
                            } else {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return booking(
                                  car_name: snapshot.data['data'][index]
                                      ['car_name'],
                                  car_id: snapshot.data['data'][index]
                                      ['car_id'],
                                  car_dis: snapshot.data['data'][index]
                                      ['car_discription'],
                                  car_price: snapshot.data['data'][index]
                                      ['car_price'],
                                  car_image: snapshot.data['data'][index]
                                      ['car_image'],
                                );
                              })));
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                color: primecolore,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    text(
                                      titile:
                                          '${snapshot.data['data'][index]['car_name']}',
                                      size: 20,
                                      colors: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    text(
                                      titile:
                                          '${snapshot.data['data'][index]['car_discription']}',
                                      size: 20,
                                      colors: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    text(
                                      titile:
                                          '${snapshot.data['data'][index]['car_price']}ر.ي',
                                      size: 20,
                                      colors: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    text(
                                      titile:
                                          '${snapshot.data['data'][index]['car_rental']}',
                                      size: 20,
                                      colors: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ClipRRect(
                                        
                                        child: Image.network(
                                          '$carsimages/${snapshot.data['data'][index]['car_image']}',
                                          fit: BoxFit.contain,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
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
                        CircularProgressIndicator(),
                        text(titile: '...جاري تحميل البيانان')
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
                      color: Colors.black,
                    ),
                  )))
        ]));
  }
}
