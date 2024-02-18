import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: HexColor('#e2e3e5'),
        border: Border.all(color: HexColor('#d6d8db'))
      ),
      child: Row(
        children: [
          SizedBox(
            height: 15.0, 
            width: 15.0, 
            child: CircularProgressIndicator(
              color: HexColor('#29478f'),
              strokeWidth: 4.0,
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Loading...',
              style: TextStyle(
                color: HexColor('#29478f'),
                fontSize: 16
              )
            ),
          ),
        ],
      )
    );
  }
}