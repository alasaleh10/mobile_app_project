import 'package:flutter/material.dart';

class listtile extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final IconData TR_icon;
  const listtile(
      {super.key, required this.TR_icon, required this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: ontap,
        child: ListTile(
          leading: Icon(
            Icons.arrow_left,
            size: 30,
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: TextStyle(inherit: true),
            ),
          ),
          trailing: Icon(
            TR_icon,
            size: 30,
          ),
        ),
      ),
    );
  }
}
