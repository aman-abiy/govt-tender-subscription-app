import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String pageTitle;

  const PageTitle(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Text(pageTitle,
        style: textTheme.headline2,
      ),
    );
  }
}