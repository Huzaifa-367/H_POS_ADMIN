import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Widgets/Constant Data/button_global.dart';
import '../Widgets/Constant Data/constant.dart';
import 'log_in.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const String route = '/resetPassword';
  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String email;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color: kGreyTextColor.withOpacity(0.1),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Reset Your Password',
                          style: kTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.bold, fontSize: 21.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: globalKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'n be empty';
                                    } else if (!value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  showCursor: true,
                                  cursorColor: kTitleColor,
                                  decoration: kInputDecoration.copyWith(
                                    labelText: 'Email',
                                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                    hintText: 'Enter your email address',
                                    hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                                    contentPadding: const EdgeInsets.all(4.0),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                ButtonGlobal(
                                    buttontext: 'Reset Password',
                                    buttonDecoration: kButtonDecoration.copyWith(color: kGreenTextColor, borderRadius: BorderRadius.circular(8.0)),
                                    onPressed: (() async {
                                      if (validateAndSave()) {
                                        try {
                                          EasyLoading.show(status: "Sending Reset Email");
                                          await FirebaseAuth.instance.sendPasswordResetEmail(
                                            email: email,
                                          );
                                          EasyLoading.showSuccess('Please Check Your Inbox');
                                          if (!mounted) return;
                                          Navigator.pushNamed(context, LogIn.route);
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            EasyLoading.showError('No user found for that email.');
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('No user found for that email.'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          } else if (e.code == 'wrong-password') {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Wrong password provided for that user.'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          EasyLoading.showError(e.toString());
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                              duration: const Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                      }
                                    })),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
