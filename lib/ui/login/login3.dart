import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sevenbutlers/ui/login/events/login_bloc.dart';
import 'package:sevenbutlers/ui/login/events/login_state.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

import '../../utils/mixins/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc;

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    checkLogin();
  }

  void clearLogin() {
    SessionManager session = SessionManager();
    session.clear();
  }

  void checkLogin() async {
    SessionManager session = SessionManager();
    var isLoggedIn = await session.isLoggedIn();
    print("is logged in? $isLoggedIn");
    if (isLoggedIn != null && isLoggedIn) {
      await _initializeLocalNotification();
    }
  }

  Future _initializeLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/welcome');
            },
          )
        ],
      ),
    );
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future<bool> isLoggedIn() async {
    var isLoggedIn = await SessionManager().isLoggedIn();
    print("islogin: $isLoggedIn");
    return isLoggedIn;
  }

  Widget build(BuildContext context) {
    String _email, _password;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/background.png'),
        fit: BoxFit.cover,
      )),
      child: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
        if (state.data.isLogin) {
          _initializeLocalNotification();
          Navigator.pushNamedAndRemoveUntil(
              context, "/dashboard", (route) => false);
        }
      }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Container(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 200),
              Center(
                child: Image.asset(
                  'assets/images/sb.png',
                  width: 54.4,
                  height: 54.4,
                ),
              ),
              SizedBox(height: 29.6),
              Container(
                  height: 360.0,
                  width: 338.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.2))),
                    child: Column(children: [
                      SizedBox(height: 29.6),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Image.asset(
                                    "assets/images/arrow-left.png",
                                    width: 13.2,
                                    height: 12.4,
                                  )))
                        ],
                      ),
                      SizedBox(height: 35),
                      SizedBox(
                        width: 301.2,
                        child: TextFormField(
                          controller: _emailInputController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter email";
                            } else {
                              String matchEmail = validateEmail(value);

                              if (matchEmail != "matched") {
                                return matchEmail;
                              }
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value,
                          decoration: InputDecoration(
                            labelText: "Email Address",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: HexColor('#e8e8e8'))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#64feab'), width: 2.0),
                            ),
                            // errorText: state.data.error.emailError,
                          ),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 301.2,
                        child: TextFormField(
                          controller: _passwordInputController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter password";
                            } else {
                              String matchPassword = validatePassword(value);

                              if (matchPassword != "matched") {
                                return matchPassword;
                              }
                            }

                            return null;
                          },
                          onSaved: (value) => _password = value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: HexColor('#e8e8e8'))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#64feab'), width: 2.0),
                            ),
                            // errorText: state.data.error.passwordError,
                          ),
                        ),
                      ),
                      // SizedBox(height: 20),
                      Center(
                        child: Visibility(
                          visible: state.data.onProgress,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Center(
                        child: Visibility(
                          visible: state.data.isError,
                          child: Text(
                            state.data.error ?? '',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment
                            .center, //Center Row contents vertically,
                        children: [
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot password",
                              style: TextStyle(
                                  color: HexColor('#1884a3'),
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              String password = _password.replaceAll(
                                  RegExp(r"\s+\b|\b\s"), "");
                              _passwordInputController.text = password;

                              String email =
                                  _email.replaceAll(RegExp(r"\s+\b|\b\s"), "");
                              _emailInputController.text = email;

                              log("email: $email, password: $password");
                              loginBloc.attemptLogin(email, password);
                            } else {}
                          },
                          textColor: Colors.white,
                          color: Colors.black,
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              "Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          height: 45,
                          minWidth: 301.2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ]),
                  )),
              SizedBox(height: 40),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Don't have account?   ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )),
                  FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: HexColor("#64feab"),
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register1');
                    },
                  ),
                ],
              )
            ],
          ),
        ));
      })),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }
}
