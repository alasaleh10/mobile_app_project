import 'package:flutter/material.dart';

class Textformfiled extends StatelessWidget {
  final bool? enable;
  final TextEditingController? controller;
  
  final String lable_text;
  final TextInputType? textinput;
  final bool obsc;
  final String? Function(String?)? validat;
  final IconData? suffixicone;
  final Widget? prefxicon;
  const Textformfiled({
    super.key,
   
    required this.lable_text,
    this.suffixicone,
    this.prefxicon,
    required this.obsc,
    this.validat,
    this.textinput,
    this.enable = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool oncha = false;
    return Container(
      padding: EdgeInsets.all(8),
      child: TextFormField(
          enabled: enable,
          controller: controller,
          keyboardType: textinput,
          validator: validat,
          obscureText: obsc,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlign: TextAlign.right,
          cursorColor: Colors.black,
          cursorHeight: 30,
          decoration: InputDecoration(
          
            errorStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.black,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: prefxicon,
            suffixIcon: Icon(
              suffixicone,
              color: Colors.black,
            ),
            
            label: Align(
              alignment: Alignment.centerRight,
              child: Text(
                lable_text,
                style: TextStyle(color: Colors.black),
              ),
            ),
            labelStyle: TextStyle(),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
