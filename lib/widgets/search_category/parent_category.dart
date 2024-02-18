import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/widgets/search_category/child_categories.dart';
import 'package:alpha_tenders_mobile_app/widgets/search_category/child_category_tile.dart';
import 'package:flutter/material.dart';

class ParentCategory extends StatelessWidget {
  final Category category;

  const ParentCategory({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (category.isParent && !category.hasParent && category.children.isNotEmpty)
      ? Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.grey),
              right: BorderSide(width: 0.5, color: Colors.grey),
              bottom: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: ChildCategories(category: category),
        ) : Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.grey),
              right: BorderSide(width: 0.5, color: Colors.grey),
              bottom: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: ChildCategoryTile(category: category),
        ); 
  }
}
