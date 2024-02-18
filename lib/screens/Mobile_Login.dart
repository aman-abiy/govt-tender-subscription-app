import 'package:alpha_tenders_mobile_app/dtos/Login_Credentials.dart';
import 'package:alpha_tenders_mobile_app/dtos/Mobile_Number.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/input_decoration.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/phone_number_formatter.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/utils/validators.dart';
import 'package:alpha_tenders_mobile_app/widgets/button_loading_indicator.dart';
import 'package:alpha_tenders_mobile_app/widgets/copyright.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/powerd_by.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({Key key}) : super(key: key);


  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  LoginCredentials loginCredentials = LoginCredentials();  
  final _formKey = GlobalKey<FormState>();

  PhoneNumber number = PhoneNumber(isoCode: 'ET');

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Alpha Tenders',
                        style: textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Login',
                        style: textTheme.headline2,
                      ),
                    ),
                    const ErrorMessage(),
                    Container(
                      height: 65,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {},
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        // textFieldController: controller,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          if(number != null) {
                            loginCredentials.mobile = number.phoneNumber;
                          }
                        },
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
                        child: Text('Forgot Passowrd?',
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
                        child: const Text('Login with Email', style: TextStyle(color: Colors.black54),),
                        style: buttonStyle('#dadadd'),
                        onPressed: accountProvider.isLoading ? null : () => Navigator.of(context).pushReplacementNamed(Routes.EMAIL_LOGIN),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.REGISTER);
                        },
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