import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money/constants/colors.dart';


showLoadingWidget(BuildContext context) async {
 return showDialog(
   context: context,
   barrierDismissible: false,
   builder: (BuildContext context) {
     return Dialog(
       backgroundColor: Colors.transparent,
       elevation: 0,
       insetAnimationDuration: Duration(microseconds: 300),
       insetAnimationCurve: Curves.easeInBack,
       child: Container(
         height: 80,
         width: 100,
         margin: EdgeInsets.only(left: 60,right: 60),
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
             color: Colors.white
         ),
         child: Center(
           child:  SpinKitWave(
             size: 40,
             itemBuilder: (BuildContext context, int index) {
               return DecoratedBox(
                 decoration: BoxDecoration(
                   color: index.isEven ? AppColors.primarycolor :  Colors.white,
                 ),
               );
             },
           ),
         ),
       ),
     );
   },
 );
}

