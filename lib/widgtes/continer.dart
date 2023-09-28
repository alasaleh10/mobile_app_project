import 'package:flutter/material.dart';


class continer extends StatelessWidget {
  final String imagename;
  final void Function()? ontap;
  const continer({super.key, this.ontap, required this.imagename});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Image.asset(
          imagename,
        ),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
