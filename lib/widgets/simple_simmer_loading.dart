import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SimpleShimmerLoading extends StatelessWidget {
  const SimpleShimmerLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          color: Colors.white
        )
      )
    );
  }
}