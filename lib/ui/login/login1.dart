import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevenbutlers/config/routes/route_generator.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        primaryColor: HexColor('#64feab'),
        accentColor: HexColor('#64feab'),
        primaryColorDark: HexColor('#64feab'),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class LoginMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginemail = () {
      Navigator.pushNamed(context, '/loginemail');
    };

    var loginsocial = () {
      Navigator.pushNamed(context, '/loginsocial');
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
                      borderRadius: BorderRadius.all(Radius.circular(5.2))),
                  child: Column(children: [
                    SizedBox(height: 29.6),
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                      onPressed: loginemail,
                      textColor: Colors.white,
                      color: Colors.black,
                      child: SizedBox(
                        width: 250,
                        child: Text(
                          "Log in with email",
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
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: loginsocial,
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: SizedBox(
                        width: 250,
                        child: Text(
                          "Log in with social media",
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
        )),
      ),
    );
  }
}

// class Login extends StatelessWidget {
//   @override

// }
