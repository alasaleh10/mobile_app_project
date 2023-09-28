import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/adminpages/admin_log.dart';
import 'package:mobile_app_project/authpages/signup.dart';
import 'package:mobile_app_project/main.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';
import 'package:mobile_app_project/viewpages/home.dart';
import 'package:mobile_app_project/bottom_pages/home_page.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:mobile_app_project/widgtes/textform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with curd {
  bool _obs = true;
  var username = TextEditingController();
  var password = TextEditingController();
  var _key = GlobalKey<FormState>();

  login() async {
    if (_key.currentState!.validate()) {
      var response = await postRequst(loginuserserver,
          {'username': username.text, 'password': password.text});

      if (response['status'] == 'sucss') {
        sharedPref.setInt('id', response['data']['id']).toString();

        Get.offAll(home());
      } else {
        Get.snackbar('عذرا', 'اسم المستخدم او كلمة المرور غير صحيحه',
            duration: Duration(seconds: 4),
            icon: Icon(Icons.warning),
            colorText: Colors.black,
            backgroundColor: prime_contenercolor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SafeArea(
            child: Container(
          color: primecolore,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: (() {
                      Get.offAll(admif_log());
                    }),
                    icon: Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                      size: 40,
                    )),
              ),
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
                controller: password,
                prefxicon: InkWell(
                  onTap: () {
                    setState(() {
                      _obs = !_obs;
                    });
                  },
                  child: Icon(_obs ? Icons.visibility : Icons.visibility_off),
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
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: text(
                    titile: 'نسيت كلمة المرور؟',
                    size: 18,
                    colors: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(signup());
                    },
                    child: text(
                      titile: 'ليس لديك حساب؟  تسجيل',
                      size: 18,
                      colors: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: (() {
                  login();
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.arrow_right,
                      size: 50,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
