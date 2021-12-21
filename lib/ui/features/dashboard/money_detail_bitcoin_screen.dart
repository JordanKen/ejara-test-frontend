import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money/constants/colors.dart';
import 'package:money/constants/font_family.dart';
import 'package:money/core/models/bitcoin/bitcoinModel.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/core/viewmodels/app_provider.dart';
import 'package:money/ui/widgets/app_bar_with_textflied/default_app_bar.dart';
import 'package:money/ui/widgets/shimmer_list.dart';
import 'package:provider/provider.dart';




class MoneyDetailBitcoinScreen extends StatefulWidget {
  @override
  _MoneyDetailState createState() => _MoneyDetailState();
}

class _MoneyDetailState extends State<MoneyDetailBitcoinScreen> with TickerProviderStateMixin {


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
              "BTC Transactions",
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
            await money.fetchMoneyBitcoinsAsync();
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
              child:  money.bitcoinList!.isEmpty? ShimmerList() : ListView.builder(
                itemCount: money.bitcoinList!.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20,right: 10,left: 10),
                itemBuilder: (BuildContext context, int index) {
                  final item = money.bitcoinList![index];
                  return  Container(
                    height: 80,
                    margin: EdgeInsets.only(bottom: 0),
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
                                  "${item.tx_index!}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color:Color(0xff496280),
                                    fontFamily: FontFamily.latoRegular,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              subtitle:Text(
                                  "Detail about the transaction",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:AppColors.grayColor,
                                    fontFamily: FontFamily.latoRegular,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              trailing:Text(
                                  '${item.fee} BTC',
                                  //"${DateTime.fromMicrosecondsSinceEpoch(item.time!)}",
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
                },),
            )

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

  openDetailDispensation(BuildContext context,BitcoinModel item ) async{
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
                      "assets/images/images_1.PNG",
                      fit: BoxFit.cover,
                      height: 150,
                      width: 250,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Text(
                    "${item.tx_index}",
                    textAlign: TextAlign.left,
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
                  "history",
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
                                          "Size",
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
                                          "${item.size}",
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
                                          "Ver",
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
                                          "${item.ver}",
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
                                          "${item.fee} BTC",
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
                                          "Weight",
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
                                          "${item.weight}",
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
                      text:"Is double spent: ",
                      style: TextStyle(
                        fontSize:14,
                        color:Color(0xff014864).withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                        fontFamily:FontFamily.latoRegular ,
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                          text:" ${item.double_spend}",
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
               /* RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text:"Number: ",
                      style: TextStyle(
                        fontSize:14,
                        color:Color(0xff014864).withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                        fontFamily:FontFamily.latoRegular ,
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                          text:"${item.fee}",
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
                ),*/
              ],
            ),
          ),
          );
        });
  }
}


