import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money/constants/colors.dart';
import 'package:money/constants/font_family.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/core/viewmodels/app_provider.dart';
import 'package:money/core/viewmodels/user_provider.dart';
import 'package:money/ui/features/dashboard/money_detail_bitcoin_screen.dart';
import 'package:money/ui/widgets/app_bar_with_textflied/default_app_bar.dart';
import 'package:provider/provider.dart';
import 'money_detail_tezos_screen.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with TickerProviderStateMixin {


  //stores:---------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final money = Provider.of<AppProvider>(context);
    final auth = Provider.of<UserProvider>(context);
    return  Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        appBar: DefaultAppBar(
          showSearch: false,
          leading:[
            IconButton(
              splashRadius: 20,
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {},
            ),
            Expanded(
              child: Text(
                "Coins",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.latoRegular,
                    color: Colors.white,
                    fontSize: 18
                ),
              ),
            )
          ],
          action: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.logout,color: Colors.white,),
            onPressed: () async{
             await auth.signOut();
            },
          ),
        ),
        body:  NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  /*ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 194,
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>MoneyDetailScreen()));
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // changer la couleur en fonction du status de la prescription appeler la fonction getColorStatusOrder
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 30),
                                      height: 3,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                    ),

                                  ),
                                  Container(
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child:Text(
                                                  'Status',
                                                  style: TextStyle(
                                                      color: Colors.lightGreen,
                                                      fontSize: 13,
                                                      fontFamily: FontFamily.latoRegular,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child:Text(
                                                  '12-15-2020',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                      fontFamily: FontFamily.latoRegular,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Container(
                                          child:Text(
                                            'BITCOINS',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: FontFamily.latoRegular,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                   color: Color(0xffF0F0F0),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                //child: Icon(Icons.home,size: 40,color: Color(0xff014864),),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    'assets/images/images_1.PNG',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        textAlign: TextAlign.left,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                            text:"ID: ",
                                                            style: TextStyle(
                                                              fontSize:14,
                                                              color:Color(0xff014864),
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily:FontFamily.latoRegular ,
                                                              fontStyle: FontStyle.normal,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:"DJBBujD-DSDS55S4-SS",
                                                                style: TextStyle(
                                                                  fontSize:12,
                                                                  color:Color(0xff014864).withOpacity(0.5),
                                                                  fontWeight: FontWeight.normal,
                                                                  fontFamily:FontFamily.latoRegular ,
                                                                  fontStyle: FontStyle.normal,
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                      SizedBox(height: 8,),
                                                      RichText(
                                                        textAlign: TextAlign.left,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                            text:"REASON: ",
                                                            style: TextStyle(
                                                              fontSize:14,
                                                              color:Color(0xff014864),
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily:FontFamily.latoRegular ,
                                                              fontStyle: FontStyle.normal,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:"View all BTC transactions",
                                                                style: TextStyle(
                                                                  fontSize:12,
                                                                  color:Color(0xff014864).withOpacity(0.5),
                                                                  fontWeight: FontWeight.normal,
                                                                  fontFamily:FontFamily.latoRegular ,
                                                                  fontStyle: FontStyle.normal,
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },

                  )*/
                  Container(
                    height: 180,
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async{
                         await money.fetchMoneyBitcoinsAsync();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>MoneyDetailBitcoinScreen()));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // changer la couleur en fonction du status de la prescription appeler la fonction getColorStatusOrder
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8,),
                                    Container(
                                      child:Text(
                                        'BITCOINS',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: FontFamily.latoRegular,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF0F0F0),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            //child: Icon(Icons.home,size: 40,color: Color(0xff014864),),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/images/images_1.PNG',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                        text:"REASON: ",
                                                        style: TextStyle(
                                                          fontSize:14,
                                                          color:Color(0xff014864),
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily:FontFamily.latoRegular ,
                                                          fontStyle: FontStyle.normal,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:"View all BTC transactions",
                                                            style: TextStyle(
                                                              fontSize:12,
                                                              color:Color(0xff014864).withOpacity(0.5),
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily:FontFamily.latoRegular ,
                                                              fontStyle: FontStyle.normal,
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: ()async{
                          await money.fetchMoneyTezosAsync();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>MoneyDetailTezosScreen()));

                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8,),
                                    Container(
                                      child:Text(
                                        'Tezos',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: FontFamily.latoRegular,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF0F0F0),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            //child: Icon(Icons.home,size: 40,color: Color(0xff014864),),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/images/images_2.PNG',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                        text:"REASON: ",
                                                        style: TextStyle(
                                                          fontSize:14,
                                                          color:Color(0xff014864),
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily:FontFamily.latoRegular ,
                                                          fontStyle: FontStyle.normal,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:"View all XTZ transactions",
                                                            style: TextStyle(
                                                              fontSize:12,
                                                              color:Color(0xff014864).withOpacity(0.5),
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily:FontFamily.latoRegular ,
                                                              fontStyle: FontStyle.normal,
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                 /* Container(
                    height: 180,
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: ()async{
                          _showErrorMessage(StoreErrorModel(errorMessage: "Don't implement",type: "Error"));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // changer la couleur en fonction du status de la prescription appeler la fonction getColorStatusOrder
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8,),
                                    Container(
                                      child:Text(
                                        'ETHEREUM',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: FontFamily.latoRegular,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF0F0F0),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            //child: Icon(Icons.home,size: 40,color: Color(0xff014864),),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/images/images_3.PNG',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                        text:"REASON: ",
                                                        style: TextStyle(
                                                          fontSize:14,
                                                          color:Color(0xff014864),
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily:FontFamily.latoRegular ,
                                                          fontStyle: FontStyle.normal,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:"View all ETH transactions",
                                                            style: TextStyle(
                                                              fontSize:12,
                                                              color:Color(0xff014864).withOpacity(0.5),
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily:FontFamily.latoRegular ,
                                                              fontStyle: FontStyle.normal,
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        )
    );
  }







  /// General Methods:-----------------------------------------------------------
  _showErrorMessage(StoreErrorModel error) {
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

