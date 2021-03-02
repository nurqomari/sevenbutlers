import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sevenbutlers/ui/dashboard.dart';
import 'package:sevenbutlers/ui/login/login1.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(LoginApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        primaryColor: HexColor('#64feab'),
        accentColor: HexColor('#64feab'),
        primaryColorDark: HexColor('#64feab'),
      ),
      home: DashBoard(),
      // initialRoute: '/',
      // onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
