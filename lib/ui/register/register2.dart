import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/ui/register/events/register_bloc.dart';
import 'package:sevenbutlers/ui/register/events/register_state.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';
import "package:sevenbutlers/utils/mixins/validators.dart";
import 'package:sevenbutlers/widgets/widgets.dart';

class Register2 extends StatefulWidget {
  final String username, firstname, lastname;
  Register2({Key key, @required this.username, this.firstname, this.lastname})
      : super(key: key);

  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final formKey = new GlobalKey<FormState>();
  String _username, _password, _email, _firstname, _surname, _confirmpassword;
  RegistrationBloc registrationBloc;

  @override
  void initState() {
    super.initState();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    _username = widget.username;
    _firstname = widget.firstname;
    _surname = widget.lastname;

    //TextController to read text entered in text field
    TextEditingController password = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();

    final emailField = TextFormField(
      autofocus: false,
      validator: (value) {
        String matchEmail = validateEmail(value);
        if (matchEmail != "matched") {
          return matchEmail;
        }
      },
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Email Address"),
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

          if (passwordCheck != "matched") {
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
        }
        if (password.text != confirmpassword.text) {
          return "Password does not match";
        }
        return null;
      },
      onSaved: (value) => _confirmpassword = value,
      decoration: buildInputDecoration("Confirm Password"),
    );

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state.data.isRegister) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/dashboard", (route) => false);
            }
          },
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
            return Form(
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
                    SizedBox(height: 60),
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
                    SizedBox(height: 40.0),
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
                    passwordField,
                    SizedBox(height: 20.0),
                    confirmpasswordField,
                    SizedBox(height: 20.0),
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
                          state.data.data ?? '',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
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
                    SizedBox(
                      height: 20,
                    ),
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
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            String firstname = _firstname.replaceAll(
                                RegExp(r"\s+\b|\b\s"), "");
                            String lastname =
                                _surname.replaceAll(RegExp(r"\s+\b|\b\s"), "");
                            String email =
                                _email.replaceAll(RegExp(r"\s+\b|\b\s"), "");
                            String password =
                                _password.replaceAll(RegExp(r"\s+\b|\b\s"), "");

                            print(
                                "firstname: $firstname, lastname: $lastname, email: $email, password: $password");
                            registrationBloc.attemptRegister(
                                firstname, lastname, email, password);
                          }
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
                    SizedBox(height: 40),
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
                ));
          }),
        ),
      ),
    ));
  }
}
