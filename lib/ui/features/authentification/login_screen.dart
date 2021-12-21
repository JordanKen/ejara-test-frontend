import 'package:another_flushbar/flushbar_helper.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money/constants/colors.dart';
import 'package:money/constants/font_family.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/core/viewmodels/user_provider.dart';
import 'package:money/tools/validations/validation.dart';
import 'package:money/ui/features/authentification/register_screen.dart';
import 'package:money/ui/features/dashboard/home_screen.dart';
import 'package:money/ui/widgets/events/loading_widget.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {


  //stores:---------------------------------------------------------------------



  final _formLoginKey = GlobalKey<FormState>();


  //Navigation :---------------------------------------------------------------------
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops:[0.1,0.7],
                            colors: [
                              AppColors.primarycolor.withOpacity(0.4),
                              AppColors.primarycolor,
                            ],
                          )
                      ),
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      child:Container(
                        padding: EdgeInsets.all(70),
                        child: Image.asset(
                          'assets/logos/money-white.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.7,
                      color: AppColors.grayColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height:MediaQuery.of(context).size.height*0.72,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Welcome to MONEY APP!',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                fontFamily: FontFamily.latoBold,
                                color: Colors.black,
                                fontSize: 18
                            ),
                          ),
                        ),

                        Form(
                          key: _formLoginKey,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                  autofocus: false,
                                  cursorColor: AppColors.primarycolor,
                                  textAlignVertical: TextAlignVertical.center,
                                  style:TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: FontFamily.latoBold,
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 14
                                  ),
                                  onChanged:(String val){},
                                  controller: user.controllerEmail,
                                  validator:(String? val)=>Validations.validateEmailReg(val!),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    filled: false,
                                    labelText: 'Email Address',
                                    labelStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: FontFamily.latoBold,
                                        color: Colors.black,
                                        fontSize: 18
                                    ),
                                    fillColor: Colors.transparent,
                                    suffixIcon: Icon(Icons.visibility,color: Colors.transparent,),
                                    focusedBorder:UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.primarycolor.withOpacity(0.5),width: 0.6)
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5),width: 0.6)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  autofocus: false,
                                  cursorColor: AppColors.primarycolor,
                                  obscureText: !_passwordVisible,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: FontFamily.latoBold,
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 14
                                  ),
                                  onChanged:(String val){},
                                  controller: user.controllerPassword,
                                  validator:(String? val)=>Validations.validatePassword(val!),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelText:  'Password',
                                    labelStyle:TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: FontFamily.latoBold,
                                        color: Colors.black,
                                        fontSize: 18
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,color: Colors.grey.withOpacity(0.5),),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible =!_passwordVisible;
                                        });
                                      },
                                    ),
                                    filled: false,
                                    fillColor: Colors.transparent,
                                    focusedBorder:UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.primarycolor.withOpacity(0.5),width: 0.6)
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5),width: 0.6)
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {  },
                                  child: Text(
                                    'Forgot password?',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: FontFamily.latoRegular,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ArgonButton(
                          height: 50,
                          roundLoadingShape: true,
                          width: MediaQuery.of(context).size.width,
                          onTap: (startLoading, stopLoading, btnState) async{
                            if (_formLoginKey.currentState!.validate()) {

                              //user.loading ? CircularProgressIndicator():Container();
                              startLoading();
                              // user.loading ? await showLoadingWidget(context):Container();

                              if(await user.signIn()){

                                _showSuccessMessage(StoreErrorModel(errorMessage: 'Your login successfully',type: 'Welcome'));

                                user.loading = false;

                                user.clearController();

                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);

                              }else{
                                user.loading = false;
                                stopLoading();
                                _showErrorMessage(StoreErrorModel(errorMessage: 'Please fill in correctly fill in the email and password field',type: 'Error'));

                              }
                            }
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          loader: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          borderRadius: 25.0,
                          color: AppColors.secondarycolor,
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextButton(
                            onPressed: () {
                              user.clearController();
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RegisterScreen()));
                            },
                            child: RichText(
                              text: TextSpan(
                                  text: 'New to MONEY?',
                                  style: new TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: FontFamily.latoRegular,
                                      color: Colors.black,
                                      fontSize: 12
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' Register',
                                      style: new TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontFamily.latoRegular,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontSize: 12
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }




  /// General Methods:----------------------------------------------------------

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
  _showSuccessMessage(StoreErrorModel error) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (error != null && error.errorMessage!.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: error.errorMessage!,
          title:error.type,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }
}


