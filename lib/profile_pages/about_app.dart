import 'package:flutter/material.dart';
import 'package:mobile_app_project/widgtes/listtile.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';

class about_app extends StatelessWidget {
  const about_app({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            color: prime_contenercolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                listtile(TR_icon: Icons.handshake, title: 'اتفاقية المستخدم'),
                listtile(TR_icon: Icons.question_mark, title: 'التعليمات'),
                listtile(TR_icon: Icons.info, title: 'رقم الاصدار'),
                listtile(
                    TR_icon: Icons.sync_problem, title: 'المقترحات والشكاوي')
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
    );
  }
}
