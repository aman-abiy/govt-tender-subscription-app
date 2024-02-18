import 'package:alpha_tenders_mobile_app/dtos/Registration_Credentials.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/input_decoration.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
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

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationCredentials registrationCredentials = RegistrationCredentials();
  final _formKey = GlobalKey<FormState>();

  PhoneNumber number = PhoneNumber(isoCode: 'ET');

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, account, child) {
      return Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            children: [
              Form(
                key: _formKey,
                child: Column(
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
                      child: Text('Signup',
                        style: textTheme.headline2,
                      ),
                    ),
                    const ErrorMessage(),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        enableSuggestions: true,
                        autofocus: false,
                        autocorrect: false,
                        validator: Validators.nameValidator,
                        textInputAction: TextInputAction.done,
                        onSaved: (String val) {
                          if (val != null) {
                            registrationCredentials.fname = val.trim();
                          }
                        },
                        style: const TextStyle(fontSize: 15.0),
                        decoration: inputDecoration(
                          'First Name',
                          const Icon(Ionicons.person_outline, size: 20),
                          null,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        autofocus: false,
                        autocorrect: false,
                        validator: Validators.nameValidator,
                        textInputAction: TextInputAction.done,
                        onSaved: (String val) {
                          if (val != null) {
                            registrationCredentials.lname = val.trim();
                          }
                        },
                        style: const TextStyle(fontSize: 15.0),
                        decoration: inputDecoration(
                          'Last Name',
                          const Icon(Ionicons.person_outline, size: 20),
                          null,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        autocorrect: false,
                        validator: Validators.emailValidator,
                        textInputAction: TextInputAction.done,
                        onSaved: (String val) {
                          if (val != null) {
                            registrationCredentials.email = val.trim();
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
                            registrationCredentials.mobile = PhoneNumberFormatter.formattedMobileNumber(number);
                            print(registrationCredentials.mobile.toMap());
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
                            registrationCredentials.password = val.trim();
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
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Forgot Passowrd?',
                        style: textTheme.overline,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        child: account.isLoading ? const ButtonLoadingIndicator() : const Text('Register', style: TextStyle(color: Colors.white),),
                        style: buttonStyle('#3891f1'),
                        onPressed: account.isLoading ? null : () async {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            await account.register(registrationCredentials);
                            if(account.isLoggedIn()) {
                              Navigator.of(context).pushReplacementNamed(Routes.ALL_TENDERS);
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(Routes.EMAIL_LOGIN),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan> [
                              const TextSpan(text: 'Already have an account?', style: TextStyle(color: Colors.black)),
                              TextSpan(text: ' Login', style: textTheme.overline)
                            ]
                          )
                        ),
                      ),
                    ),
                    const Copyright(),
                    const PoweredBy()
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}