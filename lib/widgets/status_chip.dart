import 'package:flutter/material.dart';

import 'package:alpha_tenders_mobile_app/style/hex_color.dart';

class StatusChip extends StatelessWidget {
  final int closingDate;

  StatusChip(this.closingDate);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      child: Chip(
        padding: const EdgeInsets.all(0.0),
        label: SizedBox(
          height: 26.0,
          child: Text(isOpen(closingDate) ? 'open' : 'closed', 
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        clipBehavior: Clip.none,
        backgroundColor: isOpen(closingDate) ? HexColor('#28a745') : HexColor('#dc3545'),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
    );
  }

  bool isOpen(int closingDate) {
    int now = DateTime.now().millisecondsSinceEpoch;

    if(closingDate >= now) {
      return true;
    }
    return false;
  }
}
