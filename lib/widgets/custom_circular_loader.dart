import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomCircularLoader extends StatelessWidget {

  final Color color;
  final double dimensions;
  final double strokeWidth;
  const CustomCircularLoader({Key key, this.color, this.dimensions, this.strokeWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimensions ?? 25.0, 
      width: dimensions ?? 25.0,
      child: CircularProgressIndicator(
        color: color ?? HexColor('#29478f'),
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}