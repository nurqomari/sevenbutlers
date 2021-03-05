import 'package:sevenbutlers/ui/dashboard.dart';
import 'package:sevenbutlers/ui/login.dart';
import 'package:sevenbutlers/ui/login/events/login_bloc.dart';
import 'package:sevenbutlers/ui/login/login1.dart';
import 'package:sevenbutlers/ui/login/login2.dart';
import 'package:sevenbutlers/ui/login/login3.dart';
import 'package:sevenbutlers/ui/logout.dart';
import 'package:sevenbutlers/ui/register/events/register_bloc.dart';
import 'package:sevenbutlers/ui/register/events/resend_verification_bloc.dart';
import 'package:sevenbutlers/ui/register/register.dart';
import 'package:sevenbutlers/ui/register/register3.dart';
import 'package:sevenbutlers/ui/splash_screen/splash_screen_bloc.dart';
import 'package:sevenbutlers/ui/splash_screen/splash_screen_page.dart';
import 'package:sevenbutlers/ui/welcome.dart';
import 'package:sevenbutlers/ui/register/register1.dart';
import 'package:sevenbutlers/ui/register/register2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // getting the arguments passed in while calling Navigator.pushnamed

    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => SplashScreenBloc(),
                child: SplashScreenPage()));

      // case "/login":
      //   return MaterialPageRoute(builder: (_) => Login());

      case "/login1":
        return MaterialPageRoute(builder: (_) => LoginMain());

      case "/loginsocial":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => LoginBloc(),
                child: Login2()));

      case "/loginemail":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => LoginBloc(),
                  child: LoginScreen(),
                ));

      case "/logout":
        return MaterialPageRoute(builder: (_) => Logout());

      // case "/register":
      //   return MaterialPageRoute(builder: (_) => Register());

      case "/register1":
        return MaterialPageRoute(builder: (_) => Register1());

      case "/register2":
        if (args is Map)
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (BuildContext context) => RegistrationBloc(),
                  child: Register2(
                    username: args['username'],
                    firstname: args['firstname'],
                    lastname: args['lastname'],
                  )));
        return _errorRoute();

      case "/register3":
        if (args is Map)
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (BuildContext context) => ResendVerificationBloc(),
                  child: Register3(email: args['email'])));
        return _errorRoute();

      case "/dashboard":
        return MaterialPageRoute(builder: (_) => DashBoard());

      case "/welcome":
        return MaterialPageRoute(builder: (_) => Welcome(user2: null));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error route navigation"),
        ),
        body: Center(
          child: Text(
              "Your route is invalid, please check your route name and make sure all arguments are valid!"),
        ),
      );
    });
  }
}
