import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/adminpages/admin_home.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/text.dart';
import 'package:mobile_app_project/widgtes/textform.dart';

class admif_log extends StatefulWidget {
  admif_log({super.key});

  @override
  State<admif_log> createState() => _admif_logState();
}

class _admif_logState extends State<admif_log> with curd {
  bool _obs = false;
  var admin_user = TextEditingController();
  var admid_pass = TextEditingController();
  var _key = GlobalKey<FormState>();
  admin_log() async {
    if (_key.currentState!.validate()) {
      var response = await postRequst(
          adminlogin, {'name': admin_user.text, 'password': admid_pass.text});

      print(response);
      if (response['status'] == 'sucss') {
        Get.offAll(admin_home());
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
          width: double.infinity,
          color: primecolore,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: prime_contenercolor,
                radius: 30,
                backgroundImage: AssetImage('images/admin.png'),
              ),
              Textformfiled(
                validat: (value) {
                  if (value!.isEmpty) {
                    return 'لايمكن ترك الاسم فارغا';
                  }
                },
                controller: admin_user,
                lable_text: 'الاداره',
                obsc: false,
                suffixicone: Icons.admin_panel_settings_rounded,
              ),
              Textformfiled(
                validat: (value) {
                  if (value!.isEmpty) {
                    return 'لايمكن ترك كلمة المرور فارغا';
                  }
                },
                controller: admid_pass,
                lable_text: 'كلمة المرور',
                obsc: _obs,
                suffixicone: Icons.password_sharp,
                prefxicon: InkWell(
                  onTap: () {
                    _obs = !_obs;
                    setState(() {});
                  },
                  child: Icon(
                    _obs ? Icons.visibility : Icons.visibility_off,
                    color: _obs ? Colors.black : Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: (() {
                  admin_log();
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'دخول الاداره',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.arrow_right,
                      size: 30,
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
