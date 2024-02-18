import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/company_info.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:alpha_tenders_mobile_app/utils/intent_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/simple_simmer_loading.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_circular_loader.dart';
import 'package:alpha_tenders_mobile_app/widgets/subscription_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionAndBillingPage extends StatefulWidget {
  const SubscriptionAndBillingPage({ Key key }) : super(key: key);

  @override
  State<SubscriptionAndBillingPage> createState() => _SubscriptionAndBillingPageState();
}

class _SubscriptionAndBillingPageState extends State<SubscriptionAndBillingPage> {

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
        title: const Text(SUBSCRIPTION_AND_BILLING_PAGE_TITLE),        
      ),
      body: Consumer2<AccountProvider, CompanyInfoProvider>(builder: (context, accountProvider, companyInfoProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
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
                child: Text('Subscription & Billing',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline2
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              !accountProvider.account.hasActiveSubscription ? Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  color: HexColor('#f8d7da'),
                  border: Border.all(color: HexColor('#f5c6cb'))
                ),
                child: companyInfoProvider.isLoading ? const SimpleShimmerLoading() : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    accountProvider.account.subscriptions.isEmpty ? Text('Please activate your subscription by calling our office or by depositing a subscription payment fee, based on the subscription package you desire, to one of our banks accounts.',
                      style: TextStyle(color: HexColor('#721c24')),
                    ) : Text('Your account subscription has expired. Please renew your subscription by calling our office or depositing your payment to one of our Bank Accounts.',
                      style: TextStyle(color: HexColor('#721c24')),
                    ),
                    const SizedBox(height: 10),
                    Text('Give us a call once you have completed the payment, so we can confirm the transaction and activate your account. If you need to know about our service before you start, please give us a call and we\'ll help.',
                      style: TextStyle(color: HexColor('#721c24')),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => IntentHandler.launchPhoneNumber(companyInfoProvider.companyInfo?.phone1?.e164 ?? COMPANY_PHONE_NUMBER_1),
                      child: Text(companyInfoProvider.companyInfo?.phone1?.e164 ?? COMPANY_PHONE_NUMBER_1,
                        style: TextStyle(color: HexColor('#721c24'), decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () => IntentHandler.launchPhoneNumber(companyInfoProvider.companyInfo?.phone2?.e164 ?? COMPANY_PHONE_NUMBER_2),
                      child: Text(companyInfoProvider.companyInfo?.phone2?.e164 ?? COMPANY_PHONE_NUMBER_2,
                        style: TextStyle(color: HexColor('#721c24'), decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(Routes.SUBSCRIPTION_PACKAGES),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'See our subscription packages by cicking ',
                              style: TextStyle(fontSize: 14, color: HexColor('#004085')),
                            ),
                            TextSpan(
                              text: 'here.',
                              style: TextStyle(fontSize: 14, color: HexColor('#004085'), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            ),
                          ]
                        )
                      ),
                    ),
                  ],
                )
              ) : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
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
                      child: const Text('Subscription',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),                    
                      ),               
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      child: accountProvider.account.lastActiveSubscription != null ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('Status',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor('#565555')
                                  ),
                                ),
                              ),
                              subscriptionStatusChip(accountProvider.account)
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('Start Date',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor('#565555')
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(DateParser.getDate(accountProvider.account?.lastActiveSubscription?.startDate) ?? '--',
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
                                child: Text('End Date',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor('#565555')
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(DateParser.getDate(accountProvider.account?.lastActiveSubscription?.endDate) ?? '--',
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
                                child: Text('Plan',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor('#565555')
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(accountProvider.account?.lastActiveSubscription?.subscriptionPlan?.name ?? '--',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )  : Container (
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            color: HexColor('#cce5ff'),
                            border: Border.all(color: HexColor('#b8daff'))
                          ),
                          child: Text('Your subscription history will be displayed here.',
                          style: TextStyle(
                            color: HexColor('#004085'),
                            fontSize: 14
                          )
                        )
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
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
                      child: const Text('Billing History',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),                    
                      ),               
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Plan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),                  
                              Text('Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),                        
                              Text('Payment Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#565555')
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 5,
                          ),
                          accountProvider.account.subscriptions.isNotEmpty ? billingHistory(context, accountProvider) : Container (
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                color: HexColor('#cce5ff'),
                                border: Border.all(color: HexColor('#b8daff'))
                              ),
                              child: Text('Payment you have made will be displayed here.',
                              style: TextStyle(
                                color: HexColor('#004085'),
                                fontSize: 14
                              )
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      )
    );
  }

  Widget billingHistory(BuildContext context, AccountProvider accountProvider) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      reverse: true,
      itemCount: accountProvider.account.subscriptions.length,
      itemBuilder: (context, index) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(accountProvider.account?.subscriptions[index]?.subscriptionPlan?.name ?? '--',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis
                ),
              ),                        
              Expanded(
                child: Text(accountProvider.account?.subscriptions[index]?.payment?.price?.toString() ?? '--',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis
                ),
              ),                        
              Expanded(
                child: Text(DateParser.getDate(accountProvider.account?.subscriptions[index]?.payment?.paymentDate) ?? '--',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      );
    });
  }

  Widget subscriptionStatusChip(Account account) {
    List<dynamic> subscriptionMsg = SubscriptionMsgHandler.subscriptionMsg(account); 
    return SizedBox(
      height: 20.0,
      child: Chip(
        padding: const EdgeInsets.all(0.0),
        label: SizedBox(
          height: 26.0,
          child: Text(subscriptionMsg[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis, 
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        clipBehavior: Clip.none,
        backgroundColor: subscriptionMsg[1],
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
    );
  }
}