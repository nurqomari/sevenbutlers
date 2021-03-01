import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/core/auth.dart';
import 'package:sevenbutlers/core/user_provider.dart';
import 'package:sevenbutlers/utils/mixins/validators.dart';
import 'package:sevenbutlers/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _firstname, _lastname, _email, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final firstnameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter first name" : null,
      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration(),
    );

    final lastnameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter last name" : null,
      onSaved: (value) => _lastname = value,
      decoration:
          buildInputDecoration("Confirm password", Icons.account_circle),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth
            .register(_firstname, _lastname, _email, _password)
            .then((response) {
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
        appBar: AppBar(
          title: Text("Registration Form"),
          elevation: 0.1,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                label("First Name"),
                SizedBox(height: 5.0),
                firstnameField,
                SizedBox(height: 15.0),
                label("Last Name"),
                SizedBox(height: 5.0),
                lastnameField,
                SizedBox(height: 15.0),
                label("Email"),
                SizedBox(height: 5.0),
                emailField,
                SizedBox(height: 15.0),
                label("Password"),
                SizedBox(height: 10.0),
                passwordField,
                SizedBox(height: 20.0),
                // auth.loggedInStatus == Status.Authenticating
                //     ? loading
                //     :
                longButtons("Register", doRegister),
                SizedBox(height: 20),
                Visibility(
                    visible: auth.loggedInStatus == Status.Authenticating
                        ? true
                        : false,
                    child: loading)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
