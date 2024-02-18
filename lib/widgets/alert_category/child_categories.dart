import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/widgets/alert_category/child_category_tile.dart';
import 'package:alpha_tenders_mobile_app/widgets/alert_category/parent_category_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildCategories extends StatelessWidget {
  final Category category;

  const ChildCategories({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child) {
        bool isTileExpanded = accountProvider.alertCategories.toSet().intersection(category.children.map((e) => e.id).toSet()).isNotEmpty;
        return ExpansionTile(
          title: ParentCategoryTile(category: category),
          initiallyExpanded: isTileExpanded,
          children: category.children.map((category) {
            return Container(
              color: HexColor('#eff2f4'),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.grey),
                    left: BorderSide(width: 0.5, color: Colors.grey),
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ChildCategoryTile(category: category),
              ),
            );
          }).toList(),
        );
      }
    );
  }
}
