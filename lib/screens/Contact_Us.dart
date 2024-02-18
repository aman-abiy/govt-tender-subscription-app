import 'package:alpha_tenders_mobile_app/providers/company_info.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/intent_handler.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
 
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(CompanyInfoProvider().companyInfo == null) {
        CompanyInfoProvider().getCompanyInfo();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(CONTACT_US_PAGE_TITLE),        
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          const SizedBox(height: 20.0),
          Text('Contact us for any support.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: HexColor('#525252')
            ),
          ),
          const SizedBox(height: 20.0),
          Text('If you have any questions or if you want to register, use any of the below methods to reach us.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: HexColor('#525252')
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: Colors.grey),
          ),
          const SizedBox(height: 10.0),
          Consumer<CompanyInfoProvider>(
            builder: (context, companyInfoProvider, child) {
              return companyInfoProvider.isLoading ? const Loading() : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.email_rounded, color: Colors.grey.shade700),
                        const SizedBox(height: 10.0),
                        Text('Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor('#525252')
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap: () => IntentHandler.launchEmail(companyInfoProvider.companyInfo?.email ?? COMPANY_EMAIL),
                          child: Text(companyInfoProvider.companyInfo?.email,
                            style: TextStyle(
                              fontSize: 15,
                              color: HexColor('#007bff')
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.grey.shade700),
                        const SizedBox(height: 10.0),
                        Text('Phone',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor('#525252')
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          children: [
                            companyInfoProvider.companyInfo?.phone1 != null ? InkWell(
                              onTap: () => IntentHandler.launchPhoneNumber(companyInfoProvider.companyInfo?.phone1?.e164 ?? COMPANY_PHONE_NUMBER_1),
                              child: Text(companyInfoProvider.companyInfo?.phone1?.e164,
                                style: TextStyle(
                                fontSize: 15,
                                  color: HexColor('#007bff')
                                ),
                              ),
                            ) : const SizedBox.shrink(),
                            const SizedBox(height: 8.0),
                            companyInfoProvider.companyInfo?.phone2 != null ? InkWell(
                              onTap: () => IntentHandler.launchPhoneNumber(companyInfoProvider.companyInfo?.phone2?.e164 ?? COMPANY_PHONE_NUMBER_2),
                              child: Text(companyInfoProvider.companyInfo?.phone2?.e164,
                                style: TextStyle(
                                fontSize: 15,
                                  color: HexColor('#007bff')
                                ),
                              ),
                            ) : const SizedBox.shrink(),
                            const SizedBox(height: 8.0),
                            companyInfoProvider.companyInfo?.phone3 != null ? InkWell(
                              onTap: () => IntentHandler.launchPhoneNumber(companyInfoProvider.companyInfo?.phone3?.e164 ?? COMPANY_PHONE_NUMBER_1),
                              child: Text(companyInfoProvider.companyInfo?.phone3?.e164,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: HexColor('#007bff')
                                ),
                              ),
                            ) : const SizedBox.shrink(),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.telegram, color: Colors.grey.shade700),
                        const SizedBox(height: 10.0),
                        Text('Telegram',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor('#525252')
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap: () => IntentHandler.launchTelegramChannel(),
                          child: Text(companyInfoProvider.companyInfo?.telegram,
                            style: TextStyle(
                              fontSize: 15,
                              color: HexColor('#007bff')
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          )
        ],
      )
    );
  }
}