import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:flutter/material.dart';

ButtonStyle buttonStyle(String backgroundHexColor, {double borderRadius = 0.0, borderHexColor}) {
  return ButtonStyle(
    backgroundColor:  MaterialStateProperty.all(HexColor(backgroundHexColor)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: borderHexColor != null ? HexColor(borderHexColor) : HexColor(backgroundHexColor)),
        borderRadius: BorderRadius.circular(borderRadius)
      )
    )
  );
}