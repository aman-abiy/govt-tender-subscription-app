import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/models/Tender_Source.dart';
import 'package:alpha_tenders_mobile_app/providers/category.dart';
import 'package:alpha_tenders_mobile_app/providers/language.dart';
import 'package:alpha_tenders_mobile_app/providers/region.dart';
import 'package:alpha_tenders_mobile_app/providers/search.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/providers/tender_source.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/search_category/parent_category.dart';
import 'package:alpha_tenders_mobile_app/widgets/button_loading_indicator.dart';
import 'package:alpha_tenders_mobile_app/widgets/search_category_loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode myFocusNode;
  bool hasSearchValue = false;
  final TextEditingController _searchTextcontroller = TextEditingController();


  @override
  void initState() {
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(LanguageProvider().languages.isEmpty) LanguageProvider().getLanguages();
      if(TenderSourceProvider().tenderSources.isEmpty) TenderSourceProvider().getTenderSources();
      if(RegionProvider().regions.isEmpty) RegionProvider().getRegions();
      if(CategoryProvider().categories.isEmpty) CategoryProvider().getCategories();
    });
    _searchTextcontroller.text = SearchProvider().title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myFocusNode.requestFocus();
    return SafeArea(
      child: Consumer6<CategoryProvider, RegionProvider, LanguageProvider, TenderSourceProvider, TenderProvider, SearchProvider>(
        builder: (context, categoryProvider, regionProvider, languageProvider, tenderSourceProvider, tenderProvider, searchProvider, child) {
          return Scaffold(
            body: ListView(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxHeight: 50.0,
                  ),
                  child: TextFormField(
                    focusNode: myFocusNode,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    controller: _searchTextcontroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#eff2f4'),
                      contentPadding: const EdgeInsets.only(top: 8.0),
                      focusColor: Colors.grey,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          icon: Icon(hasSearchValue ? Icons.close : null, size: 28),
                          onPressed: () => {
                              if(hasSearchValue) {
                                _searchTextcontroller.clear()
                              } // clear text
                              else {
                                executeSearch(searchProvider)
                              } // execute search
                          },
                        ),
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        fontSize: 17,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                          width: 0.5
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                          width: 0.5
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.5
                        ),
                      ),
                    ),
                    onChanged: (text) {
                      if(text != null && text != '') {
                        searchProvider.title = text;
                        setState(() {
                          hasSearchValue = true;
                        });
                      } else {
                        setState(() {
                          hasSearchValue = false;
                        });
                      }
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: DropdownButtonFormField(
                              value: searchProvider.status,
                              decoration: InputDecoration(
                                hintText: 'Status',
                                hintStyle: const TextStyle(color: Colors.grey),
                                fillColor: HexColor('#eff2f4'),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0)
                              ),
                              items: TENDER_SEARCH_STATUS.map<DropdownMenuItem<String>>((String e) {
                                return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e.toUpperCase(), style: TextStyle(color: HexColor('#1c2e59')),),
                                );
                              }).toList(), 
                              onChanged: (value) { 
                                searchProvider.status = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: DropdownButtonFormField(
                              value: searchProvider.language,
                              decoration: InputDecoration(
                                hintText: 'Languages',
                                hintStyle: const TextStyle(color: Colors.grey),
                                fillColor: HexColor('#eff2f4'),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0)
                              ), 
                              items: languageProvider.languages.map<DropdownMenuItem<String>>((Language e) {
                                return DropdownMenuItem<String>(
                                  value: e.id,
                                  child: Text(e.name, style: TextStyle(color: HexColor('#1c2e59')),),
                                );
                              }).toList(), 
                              onChanged: (value) { 
                                searchProvider.language = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField(
                          value: searchProvider.region,
                          decoration: InputDecoration(
                            hintText: 'Regions',
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: HexColor('#eff2f4'),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0)
                          ),
                          items: regionProvider.regions.map<DropdownMenuItem<String>>((Region e) {
                            return DropdownMenuItem<String>(
                              value: e.id,
                              child: Text(e.name.en, style: TextStyle(color: HexColor('#1c2e59')),),
                            );
                          }).toList(), 
                          onChanged: (value) { 
                            searchProvider.region = value;  
                          },
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField(
                          value: searchProvider.tenderSource,
                          decoration: InputDecoration(
                            hintText: 'Tender Sources / News Papers',
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: HexColor('#eff2f4'),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0)
                          ),
                          items: tenderSourceProvider.tenderSources.map<DropdownMenuItem<String>>((TenderSource e) {
                            return DropdownMenuItem<String>(
                              value: e.id,
                              child: Text(e.name.en, style: TextStyle(color: HexColor('#1c2e59')),),
                            );
                          }).toList(), 
                          onChanged: (value) {
                            searchProvider.tenderSource = value;
                          },
                        ),
                      ),
                      const Divider(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                          border: Border.all(color: Colors.grey)
                        ),
                        child: (categoryProvider.isLoading && categoryProvider.categories.isEmpty) ? const SearchCategoryLoading() : buildCategorySelection(categoryProvider.categories),
                        // child: const SearchCategoryLoading(),
                      ),
                      Container(height: 55.0)
                    ],
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
              height: 55.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                            child: tenderProvider.isLoading ? const ButtonLoadingIndicator() : Text('Search',
                              style: TextStyle(color: HexColor('#eef0f1')),
                            ),
                            style: buttonStyle('#0c55a2', borderRadius: 5.0),
                            onPressed: () => executeSearch(searchProvider)
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                            child: tenderProvider.isLoading ? const ButtonLoadingIndicator() : Text('Reset',
                              style: TextStyle(color: HexColor('#6c6c6c')),
                            ),
                            style: buttonStyle('#eff2f4', borderHexColor: '#bab9b9', borderRadius: 5.0),
                            onPressed: () async {
                              searchProvider.title = null;
                              searchProvider.status = null;
                              searchProvider.language = null;
                              searchProvider.region = null;
                              searchProvider.tenderSource = null;
                              searchProvider.searchCategories.clear();
                              _searchTextcontroller.clear();
                              setState(() {
                                hasSearchValue = false;
                              });
                            }
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
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

  void executeSearch(SearchProvider searchProvider) {
    if((searchProvider.title != null && searchProvider.title.isNotEmpty) ||
      searchProvider.status != null ||
      searchProvider.language != null ||
      searchProvider.region != null ||
      searchProvider.tenderSource != null ||
      searchProvider.searchCategories.isNotEmpty) 
    {
      searchProvider.searchTenders(refresh: true);
      Navigator.of(context).pushNamed(Routes.SEARCHED_TENDERS);
    } else {
      Fluttertoast.showToast(
        msg: NO_SEARCH_CRITERIA_SELECTED_ERROR_MSG,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG
      );
    }
  }
}