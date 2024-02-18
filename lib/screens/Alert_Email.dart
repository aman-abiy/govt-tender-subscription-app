import 'package:alpha_tenders_mobile_app/models/Alert_Email.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/providers/alert_emails.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:alpha_tenders_mobile_app/widgets/tender_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AlertEmailPage extends StatefulWidget {
  final AlertEmail alertEmail;

  const AlertEmailPage({Key key, this.alertEmail}) : super(key: key);

  @override
  State<AlertEmailPage> createState() => _AlertEmailState();
} 

class _AlertEmailState extends State<AlertEmailPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AlertEmailsProvider().getAlertEmail(widget.alertEmail.id);
      AlertEmailsProvider().setAlertEmailRead(widget.alertEmail.readCheckKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: HexColor('#1c2e59'),
         elevation: 0.0
      ),
      body: Consumer<AlertEmailsProvider>(
        builder: (context, alertEmailsProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: alertEmailsProvider.isLoading ? const Loading() : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(
                    height: 30,
                    color: Colors.grey,
                  ),
                  Text(ALPHA_TENDERS,
                    style: TextStyle(
                      color: HexColor('#212529')
                    ),
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.grey,
                  ),
                  Text('Tender Alert - ${DateParser.getDate(alertEmailsProvider.alertEmail.createdAt)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: HexColor('#212529')
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      color: HexColor('#cce5ff'),
                      border: Border.all(color: HexColor('#b8daff'))
                    ),
                    child: Text('This is a summary of tenders posted on alphatenders.com on ${DateParser.getDate(alertEmailsProvider.alertEmail.createdAt)} which is selected based on your category selection.',
                      style: TextStyle(
                        color: HexColor('#004085'),
                        fontSize: 16
                      )
                    )
                  ),
                  const SizedBox(height: 5.0),
                  buildAlertEmailTenders(alertEmailsProvider.alertEmail.tenders)
                ],
              ),
            ),
          );
        }
      )
    );
  }

  Widget buildAlertEmailTenders(List<dynamic> tenders) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: tenders.length,
      itemBuilder: (BuildContext context, int index) {
        return TenderCard(tenders[index]);
      }
    );
  }
}