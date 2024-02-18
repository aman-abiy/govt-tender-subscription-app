import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({ Key key }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(USER_PROFILE_PAGE_TITLE),        
      ),
      body: Consumer<AccountProvider>(builder: (context, accountProvider, child) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border.all(color: HexColor('#d6d8db'))
              ),
              child: Text(USER_PROFILE_PAGE_TITLE,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headline2
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border.all(color: HexColor('#d6d8db'))
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      color: HexColor('#f5f4f2'),
                      border: Border.all(color: Colors.transparent)
                    ),
                    child: const Text('Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),                    
                    ),               
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('First Name',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(accountProvider.account?.firstName ?? '--',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Last Name',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(accountProvider.account?.lastName ?? '--',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Email',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(accountProvider.account?.email ?? '--',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Mobile',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(accountProvider.account?.mobile?.formatInternational ?? '--',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Registration Date',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(DateParser.getDate(accountProvider.account?.createdAt ?? 0) ?? '--',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextButton(
                    child: Text('Change Email',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    style: buttonStyle('#eff2f4', borderRadius: 5.0, borderHexColor: '#dadadd'),
                    onPressed: () => Navigator.of(context).pushNamed(Routes.CHANGE_EMAIL),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextButton(
                    child: Text('Change Password', 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    style: buttonStyle('#eff2f4', borderRadius: 5.0, borderHexColor: '#dadadd'),
                    onPressed: () => Navigator.of(context).pushNamed(Routes.CHANGE_PASSWORD),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      ),
    );
  }
}