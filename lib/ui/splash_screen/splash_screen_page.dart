import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/ui/splash_screen/splash_screen_bloc.dart';
import 'package:sevenbutlers/ui/splash_screen/splash_screen_event.dart';
import 'package:sevenbutlers/ui/splash_screen/splash_screen_state.dart';
import 'package:sevenbutlers/ui/walkthrough/intro.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  SplashScreenBloc bloc;
  Future<bool> checkFirstTime() async {
    SessionManager session = SessionManager();
    // await session.setFirstTime(false);
    bool firstTime = await session.isFirstTime();
    if (firstTime) {
      return true;
    } else {
      await session.setFirstTime(true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Intro()));
      return true;
    }
  }

  @override
  void initState() {
    checkFirstTime();
    bloc = BlocProvider.of<SplashScreenBloc>(context);
    bloc.add(RefreshToken());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 64, bottom: 16),
                    child: Image(
                      image: AssetImage(
                        'assets/images/sb.png',
                      ),
                      height: 100,
                      width: 160,
                    )),
              ),
              BlocListener<SplashScreenBloc, SplashScreenState>(
                listener: (context, state) {
                  if (state is OnSuccessRefreshToken) {
                    _handleSuccessRefreshToken(context);
                  } else if (state is OnErrorRefreshToken) {
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login1", (route) => false);
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSuccessRefreshToken(BuildContext context) async {
    Future.delayed(Duration(seconds: 1), () async {
      SessionManager session = SessionManager();
      UserData userData = await session.getUser();
      Navigator.pushNamedAndRemoveUntil(
          context, "/dashboard", (route) => false);
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
