import 'package:flutter/material.dart';

class text extends StatelessWidget {
  final FontWeight? weight;
  final double? size;
  final Color? colors;
  final String titile;
  const text({super.key, required this.titile, this.size, this.colors, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      titile,
      style: TextStyle(fontSize: size,color:colors,fontWeight: weight ),
    );
  }
}
