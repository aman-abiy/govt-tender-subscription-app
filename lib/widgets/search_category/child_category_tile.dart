import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/providers/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildCategoryTile extends StatefulWidget {
  final Category category;

  const ChildCategoryTile({Key key, this.category}) : super(key: key);

  @override
  State<ChildCategoryTile> createState() => _ChildCategoryTileState();
}

class _ChildCategoryTileState extends State<ChildCategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
      // bool _isSelected = AlertSettingController().userCategories.contains(category.id);
        bool _isSelected = searchProvider.searchCategories.contains(widget.category.id);
        return CheckboxListTile(
          title: Text(
            widget.category.name.en,
            style: TextStyle(
              color: _isSelected ? Colors.blue : Colors.black,
            ),
          ),
          value: _isSelected,
          onChanged: (bool isSelected) {
            setState(() {
              if(isSelected) {
                searchProvider.addSearchCategory(id: widget.category.id);
              } else {
                searchProvider.removeSearchCategory(id: widget.category.id);
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      }
    );
  }
}
