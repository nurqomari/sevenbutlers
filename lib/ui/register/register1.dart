import 'dart:developer';
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

  String _username, _firstname, _surname;

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter username" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Username"),
    );

    final firstnameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? "Please enter your first name" : null,
      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration("First name"),
    );

    final surnameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your surname" : null,
      onSaved: (value) => _surname = value,
      decoration: buildInputDecoration("Surname"),
    );

    var next = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        Navigator.pushNamed(context, '/register2', arguments: {
          'username': _username,
          'firstname': _firstname,
          'lastname': _surname
        });
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
                firstnameField,
                SizedBox(height: 20.0),
                surnameField,
                SizedBox(height: 20.0),
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
