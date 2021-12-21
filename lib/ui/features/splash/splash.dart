
import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/ui/features/authentification/login_screen.dart';
import 'splash_content.dart';



class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}


class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  //variables:------------------------------------------------------------------

  AnimationController? animationController;
  Animation<double>? animation;

  //stores:---------------------------------------------------------------------


  //Navigation :----------------------------------------------------------------
  void navigationToOnboardingScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(),),
          (route) => false,
    );
  }




  startTime() async {
    var _duration = new Duration(seconds: 8 );
    return new Timer(_duration, navigationToOnboardingScreen);
  }

  @override
  void initState(){
    super.initState();
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 8 ),);
    animation = new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
    });
    startTime();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores

  }


  @override
  dispose() {
    animationController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () =>  _willPop(context),
      child:  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: new Scaffold(
          body: SplashContent(animation:animation!,)
        ),
      ),
    );
  }

  // onbackpressed methods:-----------------------------------------------------
  Future<bool> _willPop(BuildContext ctx) {
    final completer = Completer<bool>();
    showModalBottomSheet(
        context: ctx,
        builder: (buildContext) {
          return SizedBox(
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Are you sure !',
                  ),
                ),
                MaterialButton(
                    child: Text(
                      "Yes",
                    ),
                    onPressed: () {
                      completer.complete(true);
                      Navigator.of(buildContext).pop();
                    }),
                MaterialButton(
                    child: Text(
                      "No",
                    ),
                    onPressed: () {
                      completer.complete(false);
                      Navigator.of(buildContext).pop(false);
                    }),
              ],
            ),
          );
        });

    return completer.future;
  }




  /// General Methods:-----------------------------------------------------------
  _showErrorMessage(StoreErrorModel? error) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (error != null && error.errorMessage!.isNotEmpty) {
        FlushbarHelper.createError(
          message: error.errorMessage!,
          title: error.type,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }


}



