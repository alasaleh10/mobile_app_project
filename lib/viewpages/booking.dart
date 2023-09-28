import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/main.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';

import 'package:mobile_app_project/widgtes/text.dart';
import 'package:mobile_app_project/widgtes/textform.dart';

import '../widgtes/prime_color.dart';

class booking extends StatefulWidget {
  final int car_price;
  final String car_image;
  final String car_dis;
  final int car_id;
  final String car_name;
  const booking(
      {super.key,
      required this.car_price,
      required this.car_image,
      required this.car_dis,
      required this.car_id,
      required this.car_name});

  @override
  State<booking> createState() => _bookingState();
}

class _bookingState extends State<booking> with curd {
  var _selectedItem;
  var _cos;

  add_booking() async {
    var response = await postRequst(add_bookingserver, {
      'user_id': sharedPref.getInt('id').toString(),
      'car_id': widget.car_id.toString(),
      'days': _selectedItem.toString(),
      'cost': _cos.toString()
    });

    if (response['status'] == 'sucss') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(

              //color: Colors.blue,
              ),
          Container(
            width: double.infinity,
            child: Image.network(
              '$carsimages/${widget.car_image}',
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
                      color: Colors.white,
                    ),
                  ))),
          Positioned(
              top: 250,
              child: Container(
                height: MediaQuery.of(context).size.height * 10,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: prime_contenercolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Align(
                                alignment: Alignment.center,
                                child: text(
                                  titile: '${widget.car_dis}',
                                  colors: Colors.white,
                                  size: 15,
                                )),
                            decoration: BoxDecoration(
                                color: primecolore,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          text(
                            titile: '${widget.car_name}',
                            colors: Colors.black,
                            weight: FontWeight.bold,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 20,
                      decoration: BoxDecoration(
                          color: primecolore,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 25, top: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: text(
                                titile: 'ملخص',
                                colors: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                      child: text(
                                    titile: '${widget.car_price}',
                                    size: 20,
                                  ))),
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: DropdownButton<int>(
                                    focusColor: Colors.white,
                                    hint: text(
                                      titile: 'عدد الايام',
                                      colors: Colors.black,
                                    ),
                                    icon: Icon(Icons.list),
                                    onChanged: (value) {
                                      setState(() {});
                                      _selectedItem = value;
                                    },
                                    value: _selectedItem,
                                    items: <int>[
                                      1,
                                      2,
                                      3,
                                      4,
                                      5,
                                      6,
                                      7,
                                      8,
                                      9,
                                      10,
                                      11,
                                      12,
                                      13,
                                      14,
                                      15
                                    ].map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                          ),
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    disabledForegroundColor: Colors.black,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    primary: Color.fromRGBO(238, 173, 7, 1)),
                                onPressed: (() {
                                  if (_selectedItem == null) {
                                    Get.snackbar(
                                        'تنبيه', 'لايمكن ترك عدد الايام فارغا');
                                  } else {
                                    _cos = _selectedItem * widget.car_price;
                                    AwesomeDialog(
                                      dialogType: DialogType.success,
                                      showCloseIcon: true,
                                      dismissOnTouchOutside: false,
                                      context: context,
                                      desc: 'الرصيد الاجمالي للحجز هو ${_cos}',
                                      btnOkText: 'تاكيد',
                                      btnOkOnPress: () {
                                        add_booking();
                                      },
                                    ).show();
                                  }
                                }),
                                child: text(
                                  titile: 'حجز الان',
                                  colors: Colors.white,
                                  size: 20,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
