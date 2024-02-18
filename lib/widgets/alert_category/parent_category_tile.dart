import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParentCategoryTile extends StatefulWidget {
  final Category category;

  const ParentCategoryTile({Key key, this.category}) : super(key: key);

  @override
  State<ParentCategoryTile> createState() => _ParentCategoryTileState();
}

class _ParentCategoryTileState extends State<ParentCategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child) {
        // bool _isSelected = AlertSettingController().userCategories.contains(category.id);
        Set<String> intersection = accountProvider.alertCategories.toSet().intersection(widget.category.children.map((e) => e.id).toSet());
        bool _isSelected = intersection.isNotEmpty && (intersection.length == widget.category.children.map((e) => e.id).length);
        return CheckboxListTile(
          contentPadding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 12),
          title: Text(
            widget.category.name.en,
            style: TextStyle(
              color: _isSelected ? Colors.blue : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: _isSelected,
          onChanged: (bool isSelected) {
              if(isSelected) {
                accountProvider.addAlertCategory(id: widget.category.id);
                accountProvider.addAlertCategory(ids: widget.category.children.map((e) => e.id).toList());
              } else {
                accountProvider.removeAlertCategory(id: widget.category.id, ids: widget.category.children.map((e) => e.id).toList());
              }
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      }
    );
  }
}
