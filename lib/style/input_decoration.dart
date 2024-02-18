import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration(String hintText, Widget prefixIcon, Widget suffixIcon) {
  return InputDecoration(
    labelText: hintText,
    hintText: hintText,
    labelStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 13.0,
    ),
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 13.0,
    ),
    
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(2.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
    ),
    fillColor: HexColor('#e8f0fe'),
    focusColor: Colors.blue,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );
}
