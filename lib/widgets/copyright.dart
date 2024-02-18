import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  const Copyright({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children:  [
            TextSpan(text: '${_getYear()} copyright ©', style: const TextStyle(color: Colors.grey)),
            TextSpan(text: ' alphatenders.com', style: textTheme.overline)
          ]
        )
      ),
    );
  }

  int _getYear() {
    DateTime date = DateTime.now();
    return date.year;
  }
}