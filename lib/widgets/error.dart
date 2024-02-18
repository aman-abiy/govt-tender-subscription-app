import 'package:alpha_tenders_mobile_app/providers/error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorMessage extends StatefulWidget {
  const ErrorMessage({ Key key }) : super(key: key);

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ErrorProvider>(builder: (context, error, child) {
      return Align(
        alignment: Alignment.center,
        child: Visibility(
          visible: error.errorMsg != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(error.errorMsg ?? '',
              style: TextStyle(color: Colors.red.shade600),
            ),
          )
        ),
      );
    } 
    );
  }
}