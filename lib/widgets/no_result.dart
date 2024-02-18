import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
  const NoResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: HexColor('#cce5ff'),
        border: Border.all(color: HexColor('#b8daff'))
      ),
      child: Text('No results found.',
        style: TextStyle(
          color: HexColor('#004085'),
          fontSize: 16
        )
      )
    );
  }
}