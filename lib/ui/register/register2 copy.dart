import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sevenbutlers/core/auth.dart';
import 'package:sevenbutlers/core/user_provider.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';
import "package:sevenbutlers/utils/mixins/validators.dart";
import 'package:sevenbutlers/widgets/widgets.dart';

class Register2 extends StatefulWidget {
  final String username, password;
  Register2({Key key, @required this.username, this.password})
      : super(key: key);

  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final formKey = new GlobalKey<FormState>();
  String _username, _password, _email, _firstname, _surname;

  @override
  Widget build(BuildContext context) {
    _username = widget.username;
    _password = widget.password;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Email Address"),
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

    var submit = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.register(_firstname, _surname, _email, _password).then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
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
                  "Email",
                  style: TextStyle(
                      color: HexColor('#1884a3'),
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 20.0),
                firstnameField,
                SizedBox(height: 20.0),
                surnameField,
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Row contents vertically,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "By continuing, you agree to",
                      style: TextStyle(
                          color: HexColor('#c7c7c7'),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Seven Butlers",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Row contents vertically,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Term of Use",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "and confirm that you have",
                      style: TextStyle(
                          color: HexColor('#c7c7c7'),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Row contents vertically,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "read",
                      style: TextStyle(
                          color: HexColor('#c7c7c7'),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Seven Butlers Privacy Policy",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Center(
                  child: MaterialButton(
                    onPressed: submit,
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
