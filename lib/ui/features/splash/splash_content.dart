import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashContent extends StatelessWidget {
  final Animation? animation;

  const SplashContent({Key? key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child:Scaffold(
        backgroundColor:Colors.white,
        body: Container(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/logos/money-ping.png",
                          width: animation!.value * 150,
                          height: animation!.value * 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ));
  }
}
