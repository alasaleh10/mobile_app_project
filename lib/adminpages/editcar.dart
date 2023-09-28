import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_project/adminpages/dsiplay_admin.dart';
import 'package:mobile_app_project/model/curd.dart';
import 'package:mobile_app_project/model/links.dart';
import 'package:mobile_app_project/widgtes/prime_color.dart';
import 'package:mobile_app_project/widgtes/textform.dart';

class editcar extends StatefulWidget {
  final int id;
  final String dis;
  final String price;
  editcar(
      {super.key, required this.id, required this.dis, required this.price});

  @override
  State<editcar> createState() => _editcarState();
}

class _editcarState extends State<editcar> with curd {
  editcar() async {
    var respons = await postRequst(editcarserver, {
      'id': widget.id.toString(),
      'dis': discription.text,
      'price': prices.text
    });
    if (respons['status'] == 'sucss') {
      Navigator.pop(context);
    }

    return respons;
  }

  @override
  void initState() {
    discription.text = widget.dis;
    prices.text = widget.price.toString();
    super.initState();
  }

  var discription = TextEditingController();

  var prices = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: prime_contenercolor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textformfiled(
                      controller: discription,
                      lable_text: 'وصف السياره',
                      obsc: false,
                      suffixicone: Icons.model_training),
                  Textformfiled(
                    controller: prices,
                    lable_text: 'السعر',
                    obsc: false,
                    suffixicone: Icons.price_change,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  MaterialButton(
                    onPressed: (() {
                      editcar();
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تعديل ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(
                          Icons.edit,
                          size: 25,
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
        ));
  }
}
