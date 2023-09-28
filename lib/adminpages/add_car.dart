import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';

import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:mobile_app_project/widgtes/textform.dart';

class add_car extends StatefulWidget {
  const add_car({super.key});

  @override
  State<add_car> createState() => _add_carState();
}

class _add_carState extends State<add_car> with curd {
  bool isloading = false;
  File? _image;
  var car_name = TextEditingController();
  var discription = TextEditingController();

  var car_price = TextEditingController();
  var _key = GlobalKey<FormState>();
  var _selectedItem;

  var imagePicker = ImagePicker();
  late var brand;

  addcar() async {
    if (_image == null)
      return Get.snackbar('عذرا', 'لايمكن ترك السيارة بدون صوره',
          duration: Duration(seconds: 4),
          icon: Icon(Icons.warning),
          colorText: Colors.black,
          backgroundColor: prime_contenercolor);
    
    if (_selectedItem == null)
      return Get.snackbar(
        'عذرا',
        "لايمكن ترك اسم الشركه فارغا",
        duration: Duration(seconds: 4),
        icon: Icon(Icons.warning),
      );
    if (_key.currentState!.validate()) {
      setState(() {});
      isloading = true;
      var respons = await PostwithFile(
          addcarserver,
          {
            'name': car_name.text,
            'discription': discription.text,
            'price': car_price.text,
            'rental': _selectedItem,
          },
          _image!);
      isloading = false;
      setState(() {});
      if (respons['status'] == 'sucss') {
        Navigator.pop(context);
      }

      isloading = false;
      setState(() {});

      
    }
  }

  gallayimage() async {
    final imagepicked =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      setState(() {
      _image = File(imagepicked!.path);
    });
    }
    else{}
    
  }

  cameraimage() async {
    final imagepicked = await imagePicker.pickImage(source: ImageSource.camera);
    if (imagePicker != null) {
      setState(() {
      _image = File(imagepicked!.path);
    });
    }
    else{}
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Stack(
          children: [
            isloading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Textformfiled(
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'لايمكن ترك اسم السيارة فارغا';
                            }
                          },
                          controller: car_name,
                          lable_text: 'اسم السياره',
                          obsc: false,
                          suffixicone: Icons.car_crash,
                        ),
                        Textformfiled(
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'لايمكن ترك موديل السيارة فارغا';
                            }
                          },
                          controller: discription,
                          lable_text: 'وصف السياره',
                          obsc: false,
                          suffixicone: Icons.model_training,
                        ),
                        Textformfiled(
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'لايمكن ترك سعر السيارة فارغا';
                            }
                          },
                          controller: car_price,
                          lable_text: 'السعر',
                          obsc: false,
                          suffixicone: Icons.price_change,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              disabledHint: text(titile: 'titile'),
                              hint: text(titile: 'اسم الشركه'),
                              icon: Icon(Icons.car_crash),
                              onChanged: (value) {
                                setState(() {});
                                _selectedItem = value;
                              },
                              value: _selectedItem,
                              items: <String>[
                                'TOYOTA',
                                'BMW',
                                'AUDI',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          child: _image == null
                              ? Center(child: Image.asset('images/car.png'))
                              : Image.file(_image!),
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 210, 168, 165),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: _image == null
                                    ? primecolore
                                    : Colors.green),
                            onPressed: (() {
                              Get.defaultDialog(
                                  backgroundColor: prime_contenercolor,
                                  radius: 15,
                                  title: 'اضافة صورة السياره ',
                                  titleStyle: TextStyle(fontSize: 18),
                                  middleText: 'الرجاء اختار موضع الصوره ',
                                  actions: [
                                    InkWell(
                                      onTap: () {
                                        cameraimage();
                                      },
                                      child: text(
                                        titile: 'الكاميرا',
                                        size: 15,
                                        colors: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        gallayimage();
                                      },
                                      child: text(
                                        titile: 'معرض الصور',
                                        size: 15,
                                        colors: Colors.black,
                                      ),
                                    ),
                                  ]);

                              setState(() {});
                            }),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: _image == null
                                      ? Colors.black
                                      : Colors.green,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                text(titile: 'اضافة صوره')
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: (() {
                            addcar();
                          
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اضافه ',
                                style: TextStyle(fontSize: 18),
                              ),
                              Icon(
                                Icons.add,
                                size: 30,
                              )
                            ],
                          ),
                        )
                      ],
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
      ),
    );
  }
}
