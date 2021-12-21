import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money/constants/colors.dart';
import 'package:money/constants/font_family.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/core/models/tezo/tezosModel.dart';
import 'package:money/core/viewmodels/app_provider.dart';
import 'package:money/ui/widgets/app_bar_with_textflied/default_app_bar.dart';
import 'package:money/ui/widgets/shimmer_list.dart';
import 'package:provider/provider.dart';




class MoneyDetailTezosScreen extends StatefulWidget {
  @override
  _MoneyDetailState createState() => _MoneyDetailState();
}

class _MoneyDetailState extends State<MoneyDetailTezosScreen> with TickerProviderStateMixin {


  //stores:---------------------------------------------------------------------

  //Navigation :---------------------------------------------------------------------
// declaration and initialisation tabBar and tabBarView
  TabController? _tabController;

  // variable
  bool? fixedScroll;
  bool readerOnly= false;
  int currentPosition = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _tabController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final money = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        showSearch: true,
        leading:[
          IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Text(
              "XTZ Transactions",
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
        action:  IconButton(
          splashRadius: 20,
          onPressed: ()async {
            await money.fetchMoneyTezosAsync();
          },
          icon: Icon(Icons.autorenew,size: 20,color: AppColors.white,),
        ),
      ),
      body:  Container(
        child:Container(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: Scrollbar(
              child: money.tezosList!.isEmpty? ShimmerList() : ListView.builder(
                itemCount: money.tezosList!.length,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: 20,right: 10,left: 10),
                itemBuilder: (BuildContext context, int index) {
                  final item = money.tezosList![index];
                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child:ListTile(
                              title:Text(
                                  "Cycle ${item.cycle!.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color:Color(0xff496280),
                                    fontFamily: FontFamily.latoRegular,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              subtitle:Text(
                                  "Level ${item.level!.toString()}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:AppColors.grayColor,
                                    fontFamily: FontFamily.latoRegular,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              trailing:Text(
                                  "${item.fees.toString()} XTZ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:Colors.black,
                                    fontFamily: FontFamily.latoBold,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: () async=>openDetailDispensation(context,item),
                            )
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 0.3),
                            padding: EdgeInsets.only(left: 13,right: 13),
                            child: Divider(color: Colors.lightGreen,height: 1,thickness: 1,)),// changer la couleur en
                        // fonction du status de la prescription appeler la fonction getColorStatusOrder
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
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

  openDetailDispensation(BuildContext context,TezosModel item) async{
    return await showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)
          ),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) =>  Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height-80,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    splashRadius: 20,
                    icon: Icon(Icons.close,color: Color(0xff014864),size: 22,),
                    onPressed: () { Navigator.pop(context); },
                  ),
                ),
                Container(
                  height: 150,
                  width: 250,
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/images_2.PNG",
                      fit: BoxFit.cover,
                      height: 150,
                      width: 250,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Text(
                    "${item.hash}",
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:22,
                      color:Color(0xff014864),
                      fontWeight: FontWeight.bold,
                      fontFamily:FontFamily.latoRegular ,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "history ${item.timestamp}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize:14,
                    color:Color(0xff014864).withOpacity(0.5),
                    fontWeight: FontWeight.normal,
                    fontFamily:FontFamily.latoRegular ,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:Color(0xff014864).withOpacity(0.111111),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.lab_flask,color: Colors.red,size: 22,),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Quantity",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:14,
                                            color:Color(0xff014864),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      Container(
                                        child: Text(
                                          "${item.fees} BTC",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:10,
                                            color:Color(0xff014864).withOpacity(0.5),
                                            fontWeight: FontWeight.normal,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:Color(0xff014864).withOpacity(0.111111),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.time_solid,color: Color(0xff014864),size: 22,),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Variation",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:14,
                                            color:Color(0xff014864),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      Container(
                                        child: Text(
                                          "${item.validations}%",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:10,
                                            color:Color(0xff014864).withOpacity(0.5),
                                            fontWeight: FontWeight.normal,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:Color(0xff014864).withOpacity(0.111111),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.creditcard,color: Color(0xff014864),size: 22,),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Level",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:14,
                                            color:Color(0xff014864),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      Container(
                                        child: Text(
                                          "${item.level}",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:10,
                                            color:Color(0xff014864).withOpacity(0.5),
                                            fontWeight: FontWeight.normal,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:Color(0xff014864).withOpacity(0.111111),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.creditcard,color: Color(0xff014864),size: 22,),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Deposit",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:14,
                                            color:Color(0xff014864),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      Container(
                                        child: Text(
                                          "${item.deposit}",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize:10,
                                            color:Color(0xff014864).withOpacity(0.5),
                                            fontWeight: FontWeight.normal,
                                            fontFamily:FontFamily.latoRegular ,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
               Container(
                  child: Text(
                    "Others informations",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize:14,
                      color:Color(0xff014864),
                      fontWeight: FontWeight.bold,
                      fontFamily:FontFamily.latoRegular ,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text:"Alias: ",
                      style: TextStyle(
                        fontSize:14,
                        color:Color(0xff014864).withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                        fontFamily:FontFamily.latoRegular ,
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                          text:" ${item.baker!=null ? item.baker!['alias']:""}",
                          style: TextStyle(
                            fontSize:14,
                            color:Color(0xff014864).withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontFamily:FontFamily.latoRegular ,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text:"Reward: ",
                      style: TextStyle(
                        fontSize:14,
                        color:Color(0xff014864).withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                        fontFamily:FontFamily.latoRegular ,
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                          text:"0",
                          style: TextStyle(
                            fontSize:14,
                            color:Color(0xff014864).withOpacity(0.5),
                            fontWeight: FontWeight.bold,
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
          );
        });
  }
}


