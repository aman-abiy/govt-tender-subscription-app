import 'package:alpha_tenders_mobile_app/providers/alert_emails.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_refresher.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertEmailsPage extends StatefulWidget {
  const AlertEmailsPage({ Key key });

  @override
  State<AlertEmailsPage> createState() => _AlertEmailsState();
}

class _AlertEmailsState extends State<AlertEmailsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AlertEmailsProvider().getAlertEmails();
    });
    super.initState();
  }

  _onRefresh() async {
    await AlertEmailsProvider().getAlertEmails(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(ALERT_EMAILS_PAGE_TITLE),        
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Consumer<AlertEmailsProvider>(
          builder: (context, alertEmailsProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white,
                    border: Border.all(color: HexColor('#d6d8db'))
                  ),
                  child: Text(ALERT_EMAILS_PAGE_TITLE,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline2
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (alertEmailsProvider.isLoading && alertEmailsProvider.alertEmails.isEmpty) ? const Loading() : const SizedBox.shrink(),
                const ErrorMessage(),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(color: HexColor('#d6d8db'))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text('Sent on',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),                  
                            Flexible(
                              child: Text('Tenders',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),                        
                            Flexible(
                              child: Text('Is Opened',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        (!alertEmailsProvider.isLoading && alertEmailsProvider.alertEmails.isEmpty) ? noAlertEmails() : Expanded(child: buildAlertEmails(context, alertEmailsProvider))
                      ]
                    )
                  ),
                ),
                // (!alertEmailsProvider.isLoading && alertEmailsProvider.alertEmails.isEmpty) ? noAlertEmails() : Expanded(child: buildAlertEmails(context, alertEmailsProvider))
              ],
            );
          }
        ),
      )
      
    );
  }

  Widget buildAlertEmails(BuildContext context, AlertEmailsProvider alertEmailsProvider) {
    return CustomScroller(
      onRefresh: _onRefresh,
      onLoading: alertEmailsProvider.getAlertEmails,
      pagination: alertEmailsProvider.alertEmailsMeta?.pagination,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: alertEmailsProvider.alertEmails.length,
        itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(Routes.ALERT_EMAIL, arguments: alertEmailsProvider.alertEmails[index]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(DateParser.getDate(alertEmailsProvider.alertEmails[index].createdAt) ?? '--',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: HexColor('#007bff')
                      ),
                    ),
                  ),                        
                  Flexible(
                    child: Text(alertEmailsProvider.alertEmails[index].tenders.length.toString() ?? '--',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),                        
                  isOpenedStatusChip(alertEmailsProvider.alertEmails[index].isOpened)
                ],
              ),
            ),
            const Divider(),
          ],
        );
      }),
    );
  }

  Widget isOpenedStatusChip(bool status) {
    return SizedBox(
      height: 20.0,
      child: Chip(
        padding: const EdgeInsets.all(0.0),
        label: SizedBox(
          height: 26.0,
          child: Text(status ? 'Yes' : 'No', 
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        clipBehavior: Clip.none,
        backgroundColor: status ? HexColor('#28a745') : HexColor('#dc3545'),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
    );
  }

  Widget noAlertEmails() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: HexColor('#cce5ff'),
        border: Border.all(color: HexColor('#b8daff'))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('To receive Alert Emails, select Tender Categories and Regions you wish to receive alerts on.',
            style: TextStyle(
              color: HexColor('#004085'),
              fontSize: 16
            )
          ),
          const SizedBox(height: 15.0),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(Routes.SETTINGS),
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Click',
                    style: TextStyle(fontSize: 16, color: HexColor('#004085')),
                  ),
                  TextSpan(
                    text: ' here ',
                    style: TextStyle(fontSize: 16, color: HexColor('#004085'), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'to select alert categories.',
                    style: TextStyle(fontSize: 16, color: HexColor('#004085')),
                  ),
                ]
              )
            ),
          )
        ],
      )
    );
  }
}