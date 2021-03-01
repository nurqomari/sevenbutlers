import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sevenbutlers/core/auth.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';
import 'package:sevenbutlers/widgets/widgets.dart';

class Login3 extends StatefulWidget {
  @override
  _Login3State createState() => _Login3State();
}

class _Login3State extends State<Login3> {
  final formKey = new GlobalKey<FormState>();

  String _email, _password;

  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your email" : null,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Email"),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Password"),
    );

    var doLogin = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(_email, _password);

        successfulMessage.then((response) {
          if (response['status']) {
            User2 user2 = response['user'];
            // Provider.of<UserProvider2>(context, listen: false).setUser(user2);
            Navigator.pushNamed(context, '/welcome', arguments: user2);
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        )),
        child: Container(
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
              height: 350.0,
              width: 338.0,
              color: Colors.transparent,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.2))),
                  child: Form(
                    key: formKey,
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
                        child: emailField,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 301.2,
                        child: passwordField,
                      ),
                      SizedBox(height: 20),
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
                          onPressed: doLogin,
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
            ),
            SizedBox(height: 50),
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
        )),
      ),
    );
  }
}
