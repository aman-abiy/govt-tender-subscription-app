import 'package:flutter/material.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15.0, 
      width: 15.0, 
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 4.0,
      )
    );
  }
}