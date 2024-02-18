import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:flutter/material.dart';

class PoweredBy extends StatelessWidget {
  const PoweredBy({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children:  [
            const TextSpan(text: 'powered by', style: TextStyle(color: Colors.grey)),
            TextSpan(text: ' arppo', style: TextStyle(color: HexColor('#5da4db'))),
            TextSpan(text: ' technologies', style: TextStyle(color: HexColor('#ee9d2c')))
          ]
        )
      ),
    );
  }
}