//Note: This needs to be changed to flutter package for Native apps
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:money/routing/routes.dart';
import 'package:money/tools/setup/locator.dart';
import 'package:money/ui/features/authentification/login_screen.dart';
import 'package:money/ui/features/dashboard/home_screen.dart';
import 'package:money/ui/features/splash/splash.dart';
import 'package:provider/provider.dart';
import 'constants/enums.dart';
import 'constants/strings.dart';
import 'core/viewmodels/app_provider.dart';
import 'core/viewmodels/user_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(); // initialisation variable global
  runZonedGuarded(() async {
    runApp(Phoenix(child: MoneyApp()));
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
  });

  //change color status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));
}

class MoneyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppProvider>.value(value: AppProvider()),
          ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          themeMode: ThemeMode.light,
          home: ChangeNotifierProvider(
            create: (BuildContext context) {  },
            child: Consumer(
              builder: (context,UserProvider user, child) {
                switch (user.currentStatus) {
                  case StatusConnection.Uninitialized:
                    return  HomeScreen();
                  case StatusConnection.Unauthenticated:
                    return LoginScreen();
                  case StatusConnection.Authenticated:
                    return HomeScreen();
                  default:
                    return SplashScreen();
                }
              },
            ),
          ),
          routes: Routes.routes,

        )
    );

  }
}


