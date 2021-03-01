import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/ui/login/events/login_bloc.dart';
import 'package:sevenbutlers/ui/login/events/login_state.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';
import 'package:sevenbutlers/utils/services/social_login_service.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  LoginBloc loginBloc;

  Widget build(BuildContext context) {
    SocialLoginService loginService = new SocialLoginService();
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            )),
            child: Container(
                child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
              if (state.data.isLogin) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            }, child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: 280.2),
                  Center(
                    child: Image.asset(
                      'assets/images/sb.png',
                      width: 54.4,
                      height: 54.4,
                    ),
                  ),
                  SizedBox(height: 29.6),
                  Container(
                    height: 241.2,
                    width: 338.0,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.2))),
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
                          MaterialButton(
                            onPressed: () {
                              loginService.signInWithFacebook();
                            },
                            textColor: Colors.white,
                            color: HexColor("#3b5998"),
                            child: SizedBox(
                                width: 250,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 35),
                                        child: Image.asset(
                                          "assets/images/facebook.png",
                                          width: 7.6,
                                          height: 16.4,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Log in with Facebook",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                )),
                            height: 45,
                            minWidth: 301.2,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              loginService.signInWithGoogle();
                            },
                            textColor: Colors.white,
                            color: Colors.black,
                            child: SizedBox(
                                width: 250,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Image.asset(
                                          "assets/images/apple.png",
                                          width: 13.2,
                                          height: 16,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Log in with Apple",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                )),
                            height: 45,
                            minWidth: 301.2,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          )
                        ])),
                  ),
                  SizedBox(height: 80),
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
              );
            })))));
  }
}
