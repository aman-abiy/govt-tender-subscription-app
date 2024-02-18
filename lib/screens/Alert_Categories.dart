import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/providers/category.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/widgets/alert_category/parent_category.dart';
import 'package:alpha_tenders_mobile_app/widgets/button_loading_indicator.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AlertCategoriesPage extends StatefulWidget {
  const AlertCategoriesPage({Key key}) : super(key: key);

  @override
  State<AlertCategoriesPage> createState() => _AlertCategoriesPageState();
}

class _AlertCategoriesPageState extends State<AlertCategoriesPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(CategoryProvider().categories.isEmpty) CategoryProvider().getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#1c2e59'),
            title: const Text(ALERT_CATEGORIES_PAGE_TITLE), 
          ),
          body: (categoryProvider.isLoading && categoryProvider.categories.isEmpty) ? 
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Loading()
            ) : SingleChildScrollView(
              child: Column(
                children: [
                  buildCategorySelection(categoryProvider.categories),
                ],
              ),
            ),
          bottomSheet: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                    child: categoryProvider.isLoading ? const ButtonLoadingIndicator() : Text('Save',
                      style: TextStyle(color: HexColor('#eef0f1')),
                    ),
                    style: buttonStyle('#1a79de', borderRadius: 5.0),
                    onPressed: () async {
                      bool status = await categoryProvider.updateAlertCategories();
                      print('customHttpResponse.status 2 $status');
                      if(status) {
                        Fluttertoast.showToast(
                          msg: ALERT_SETTINGS_UPDATED_STATUS_MSG,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: ALERT_SETTINGS_UPDATE_FAILED_STATUS_MSG,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget buildCategorySelection(List<Category> categories) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ParentCategory(category: categories[index]);
      }
    );
  }
}