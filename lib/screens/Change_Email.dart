import 'package:alpha_tenders_mobile_app/dtos/Login_Credentials.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/input_decoration.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/validators.dart';
import 'package:alpha_tenders_mobile_app/widgets/button_loading_indicator.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {

  LoginCredentials loginCredentials = LoginCredentials();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(CHANGE_EMAIL_PAGE_TITLE),        
      ),
      body: Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
          loginCredentials.email = accountProvider.account.email;
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                child: Text(CHANGE_EMAIL_PAGE_TITLE,
                  style: textTheme.headline2
                ),
              ),
              const SizedBox(
                height: 10,
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
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Your current email is',
                        style: TextStyle(fontSize: 14, color: HexColor('#004085')),
                      ),
                      TextSpan(
                        text: ' ${accountProvider.account.email}. ',
                        style: TextStyle(fontSize: 14, color: HexColor('#004085'), fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'After you change your email, you will only be using the new email you submit as your login email. All alert emails will be sent to the new email only.',
                        style: TextStyle(fontSize: 14, color: HexColor('#004085')),
                      ),
                    ]
                  )
                ), 
              ),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const ErrorMessage(),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45.0,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: true,
                          autofocus: false,
                          autocorrect: false,
                          validator: Validators.emailValidator,
                          initialValue: accountProvider.account.email,
                          onSaved: (String val) {
                            if (val != null) {
                              loginCredentials.email = val.trim();
                            }
                          },
                          style: const TextStyle(fontSize: 15.0),
                          decoration: inputDecoration(
                            'Email Address',
                            const Icon(Ionicons.mail_outline, size: 20),
                            null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextButton(
                              child: Text('Close', style: TextStyle(color: Colors.grey.shade600),),
                              style: buttonStyle('#eff2f4', borderRadius: 5.0, borderHexColor: '#dadadd'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextButton(
                              child: accountProvider.isLoading ? const ButtonLoadingIndicator() : const Text('Save', style: TextStyle(color: Colors.white),),
                              style: buttonStyle('#1a79de', borderRadius: 5.0),
                              onPressed: () async{ 
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  if(accountProvider.account.email != loginCredentials.email) {
                                    bool status = await accountProvider.changeEmail(loginCredentials);
                                    if(status) {
                                      Fluttertoast.showToast(
                                        msg: EMAIL_UPDATED_STATUS_MSG,
                                        gravity: ToastGravity.BOTTOM,
                                        toastLength: Toast.LENGTH_LONG
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: EMAIL_UPDATE_FAILED_STATUS_MSG,
                                        gravity: ToastGravity.BOTTOM,
                                        toastLength: Toast.LENGTH_LONG
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: NO_CHANGE_IN_EMAIL_STATUS_MSG,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }
      )
    );
  }
}