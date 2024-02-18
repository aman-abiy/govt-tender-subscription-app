import 'package:alpha_tenders_mobile_app/dtos/Login_Credentials.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/input_decoration.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/utils/validators.dart';
import 'package:alpha_tenders_mobile_app/widgets/button_loading_indicator.dart';
import 'package:alpha_tenders_mobile_app/widgets/copyright.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/powerd_by.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key key}) : super(key: key);


  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  LoginCredentials loginCredentials = LoginCredentials();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
      return Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Alpha Tenders',
                        style: TextStyle(
                          color: HexColor('#1c2e59'),
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Login',
                        style: TextStyle(
                          color: HexColor('#1c2e59'),
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    // Divider(color: Colors.grey.shade400),
                    const ErrorMessage(),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        autofocus: false,
                        autocorrect: false,
                        validator: Validators.emailValidator,
                        textInputAction: TextInputAction.done,
                        onSaved: (String val) {
                          if (val != null) {
                            loginCredentials.email = val.trim();
                          }
                        },
                        style: const TextStyle(fontSize: 15.0),
                        decoration: inputDecoration(
                          'Email',
                          const Icon(Ionicons.mail_outline, size: 20),
                          null,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        autofocus: false,
                        autocorrect: false,
                        validator: Validators.passwordValidator,
                        textInputAction: TextInputAction.done,
                        onSaved: (String val) {
                          if (val != null) {
                            loginCredentials.password = val.trim();
                          }
                        },
                        style: const TextStyle(fontSize: 15.0),
                        decoration: inputDecoration(
                          'Password',
                          const Icon(Ionicons.lock_closed_outline, size: 20),
                          null,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(Routes.FORGOT_PASSWORD),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text('Forgot Password?',
                          style: textTheme.overline,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        child: accountProvider.isLoading ? const ButtonLoadingIndicator() : const Text('Continue', style: TextStyle(color: Colors.white),),
                        style: buttonStyle('#3891f1'),
                        onPressed: accountProvider.isLoading ? null : () async {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            await accountProvider.login(loginCredentials);
                            if(accountProvider.isLoggedIn()) {
                              Navigator.of(context).pushReplacementNamed(Routes.ALL_TENDERS);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        child: const Text('Login with Phone Number', style: TextStyle(color: Colors.black54),),
                        style: buttonStyle('#dadadd'),
                        onPressed: accountProvider.isLoading ? null : () => Navigator.of(context).pushReplacementNamed(Routes.MOBLIE_LOGIN),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(Routes.REGISTER),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(text: 'Don\'t have an account?', style: TextStyle(color: Colors.black)),
                              TextSpan(text: ' Sign Up', style: textTheme.overline)
                            ]
                          )
                        ),
                      ),
                    ),
                    const Copyright(),
                    const PoweredBy()
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}