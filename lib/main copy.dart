import 'package:flutter/material.dart';
import 'package:sevenbutlers/config/routes/route_generator.dart';
import 'package:sevenbutlers/ui/login/login1.dart';
import 'package:sevenbutlers/ui/welcome.dart';
import 'package:sevenbutlers/core/auth.dart';
import 'package:sevenbutlers/core/user_provider.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';
import 'package:provider/provider.dart';

import 'domain/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User2> getUserData() => UserPreferences().getUser2();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider2()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: "Montserrat",
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                // UserPreferences().removeUser();
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.access_token == null)
                      return LoginMain();
                    else
                      UserPreferences().removeUser();
                    return Welcome(user2: snapshot.data);
                }
              }),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute),
    );
  }
}
