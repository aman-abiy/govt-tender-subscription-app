import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchCategoryLoading extends StatelessWidget {
  const SearchCategoryLoading({Key key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2.0,
              color: Colors.white
            ), 
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2.0,
              color: Colors.white
            ),
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              color: Colors.white
            ),
          ],
        )
      )
    );
  }
}