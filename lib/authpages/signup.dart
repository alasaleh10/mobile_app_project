import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_project/authpages/login.dart';
import 'package:mobile_app_project/bottom_pages/home_page.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';
import 'package:mobile_app_project/viewpages/home.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';

import '../widgtes/text.dart';
import '../widgtes/textform.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> with curd {
  bool _obs = false;
  var username = TextEditingController();
  var name = TextEditingController();

  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var _key = GlobalKey<FormState>();
  File? _image;

  ImagePicker imagePicker = ImagePicker();

  gallayimage() async {
    final imagepicked =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagePicker == null) {
      return;
    }
    setState(() {
      _image = File(imagepicked!.path);
    });
  }

  cameraimage() async {
    final imagepicked = await imagePicker.pickImage(source: ImageSource.camera);
    if (imagePicker == null) {
      return;
    }
    setState(() {
      _image = File(imagepicked!.path);
    });
  }

  Signup_userr() async {
    if (_image == null)
      return Get.snackbar('عذرا', 'لايمكن ترك صورة الملف الشخصي فارغه',
          duration: Duration(seconds: 4),
          icon: Icon(Icons.warning),
          colorText: Colors.black,
          backgroundColor: prime_contenercolor);
    if (_key.currentState!.validate()) {
      var response = await PostwithFile(
          signupuserserver,
          {
            'name': name.text,
            'username': username.text,
            'email': email.text,
            'password': password.text,
            "phone": phone.text
          },
          _image!);
      print(response);
      if (response['status'] == 'sucss') {
        Get.snackbar('نجح التسجيل', '${name.text}تم تسجيل حسابك',
            duration: Duration(seconds: 4),
            icon: Icon(Icons.warning),
            colorText: Colors.black,
            backgroundColor: prime_contenercolor);

        Get.offAll(login());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primecolore,
      body: Form(
        key: _key,
        child: SafeArea(
            child: Stack(
          children: [
            SizedBox(
              height: 2500,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          backgroundColor: prime_contenercolor,
                          radius: 15,
                          title: 'اضافة الصوره الشخصيه',
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
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        child: _image == null
                            ? Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 60,
                              )
                            : Image.file(_image!),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      // backgroundImage: AssetImage('images/my.jpg'),
                      radius: 50,
                    ),
                  ),
                  Textformfiled(
                      controller: name,
                      validat: (value) {
                        if (value!.isEmpty) {
                          return 'لايمكن ترك الاسم  فارغا';
                        }
                      },
                      suffixicone: Icons.person,
                      lable_text: 'الاسم',
                      obsc: false),
                  Textformfiled(
                    controller: username,
                    lable_text: 'اسم المستخدم',
                    suffixicone: Icons.person,
                    obsc: false,
                    validat: (value) {
                      if (value!.isEmpty) {
                        return 'لايمكن ترك اسم المستخدم فارغا';
                      }
                    },
                  ),
                  Textformfiled(
                    controller: email,
                    lable_text: 'الايميل',
                    suffixicone: Icons.mail,
                    obsc: false,
                    validat: (value) {
                      if (value!.isEmpty) {
                        return 'لايمكن ترك الايميل فارغا';
                      }
                    },
                  ),
                  Textformfiled(
                    textinput: TextInputType.phone,
                    controller: phone,
                    lable_text: 'رقم الجوال',
                    suffixicone: Icons.phone_android,
                    obsc: false,
                    validat: (value) {
                      if (value!.isEmpty) {
                        return 'لايمكن ترك اسم المستخدم فارغا';
                      }
                    },
                  ),
                  Textformfiled(
                    controller: password,
                    prefxicon: InkWell(
                      onTap: () {
                        setState(() {
                          _obs = !_obs;
                        });
                      },
                      child:
                          Icon(_obs ? Icons.visibility : Icons.visibility_off),
                    ),
                    lable_text: 'كلمة المرور',
                    suffixicone: Icons.password,
                    obsc: _obs,
                    validat: (value) {
                      if (value!.isEmpty) {
                        return 'لايمكن ترك كلمة المرور فارغا';
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: (() {
                      Signup_userr();
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تسجيل ',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 40,
                          color: Colors.white,
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
        )),
      ),
    );
  }
}
