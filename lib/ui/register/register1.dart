import 'dart:developer';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';
import 'package:sevenbutlers/utils/mixins/validators.dart';
import 'package:sevenbutlers/widgets/widgets.dart';

class Register1 extends StatefulWidget {
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password, _confirmpassword;

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter username" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Username"),
    );

    final passwordField = TextFormField(
      controller: password,
      autofocus: false,
      obscureText: true,
      validator: (String value) {
        log(value);
        if (value.isEmpty) {
          return "Please enter password";
        } else {
          String passwordCheck = validatePassword(value);

          if(passwordCheck != "matched"){
            return passwordCheck;
          }
        }
        return null;
      },
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Password"),
    );

    final confirmpasswordField = TextFormField(
      controller: confirmpassword,
      autofocus: false,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please re-enter password';
        }else{
          String passwordCheck = validatePassword(value);

          if(passwordCheck != "matched"){
            return passwordCheck;
          }
        }
        if (password.text != confirmpassword.text) {
          return "Password does not match";
        }
        return null;
      },
      onSaved: (value) => _confirmpassword = value,
      decoration: buildInputDecoration("Confirm Password"),
    );

    var next = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        Navigator.pushNamed(context, '/register2',
            arguments: {'username': _username, 'password': _password});
      } else {
        // Flushbar(
        //   title: "Invalid form",
        //   message: "Please Complete the form properly",
        //   duration: Duration(seconds: 10),
        // ).show(context);
      }
    };

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Image.asset(
                              "assets/images/arrow-left.png",
                              width: 13.2,
                              height: 12.4,
                            ))),
                  ],
                ),
                SizedBox(height: 80),
                Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 60.0),
                Text(
                  "Username",
                  style: TextStyle(
                      color: HexColor('#1884a3'),
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.0),
                usernameField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 20.0),
                confirmpasswordField,
                SizedBox(height: 20.0),
                Text(
                  "Your password must have:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3.0),
                Row(
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: 9.6),
                    SizedBox(width: 10),
                    Text(
                      "8 to 20 characters",
                      style: TextStyle(
                          color: HexColor('#c7c7c7'),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 3.0),
                Row(
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: 9.6),
                    SizedBox(width: 10),
                    Text(
                      "Letter, number and special characters",
                      style: TextStyle(
                          color: HexColor('#c7c7c7'),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Center(
                  child: MaterialButton(
                    onPressed: next,
                    textColor: Colors.white,
                    color: Colors.black,
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        "Next",
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 80),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Allready have account?   ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )),
                    InkWell(
                      // padding: EdgeInsets.only(left: 0.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: HexColor("#1884a3"),
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/loginemail');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
