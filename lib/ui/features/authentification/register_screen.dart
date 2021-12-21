import 'package:another_flushbar/flushbar_helper.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:money/constants/colors.dart';
import 'package:money/constants/font_family.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/core/viewmodels/user_provider.dart';
import 'package:money/tools/validations/validation.dart';
import 'package:money/ui/features/authentification/login_screen.dart';
import 'package:money/ui/widgets/events/loading_widget.dart';
import 'package:provider/provider.dart';



class RegisterScreen extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {


  //stores:---------------------------------------------------------------------


  final _formRegisterKey = GlobalKey<FormState>();


 // Navigation :---------------------------------------------------------------------
  bool? _passwordVisible;
  bool isSwitchBeneficiary = false;

  String? phoneNumber;
  String? phoneIsoCode;
  String? confirmedNumber;

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
      child: Scaffold(
        body:SingleChildScrollView(
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
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height*0.72,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
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
                              key: _formRegisterKey,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      autofocus: false,
                                      cursorColor: AppColors.primarycolor,
                                      textAlignVertical: TextAlignVertical.center,
                                      controller: user.controllerName,
                                      style:TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: FontFamily.latoBold,
                                          color: Colors.grey.withOpacity(0.5),
                                          fontSize: 14
                                      ),
                                      onChanged:(String val){},
                                      validator:(String? val)=>Validations.validateName(val!),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        filled: false,
                                        labelText: 'Username',
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
                                    IntlPhoneField(
                                      style:TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: FontFamily.latoBold,
                                          color: Colors.grey.withOpacity(0.5),
                                          fontSize: 14
                                      ),
                                      countries: ['CM','FR','CA'],
                                      controller: user.controllerPhone,
                                      validator:(String? val)=>Validations.validatePhoneNumber(val!),
                                      decoration: InputDecoration(
                                        filled: false,
                                        contentPadding: EdgeInsets.only(top: 25),
                                        suffixIcon: Icon(Icons.crop_square,color: Colors.transparent,),
                                        errorMaxLines: 1,
                                        focusedBorder:UnderlineInputBorder(
                                            borderSide: BorderSide(color: AppColors.primarycolor.withOpacity(0.5),width: 0.6)
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5),width: 0.6)
                                        ),
                                        hintText:'Enter phone number',
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: FontFamily.latoBold,
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 14
                                        ),
                                      ),
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                      },
                                      onCountryChanged: (phone) {
                                        print('Country code changed to: ' + phone.countryCode!);
                                      },
                                    ),
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
                                        labelText: 'Email address',
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
                                    TextFormField(
                                      autofocus: false,
                                      cursorColor: AppColors.primarycolor,
                                      obscureText: !_passwordVisible!,
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
                                          icon: Icon(_passwordVisible! ? Icons.visibility : Icons.visibility_off,color: Colors.grey.withOpacity(0.5),),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =!_passwordVisible!;
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
                                    SizedBox(height: 40,),
                                    ArgonButton(
                                      height: 50,
                                      roundLoadingShape: true,
                                      width: MediaQuery.of(context).size.width,
                                      onTap: (startLoading, stopLoading, btnState)async {
                                        if (_formRegisterKey.currentState!.validate()) {

                                          //user.loading ? await showLoadingWidget(context):Container();
                                          startLoading();

                                          if(await user.signUp()){

                                            user.loading = false;

                                            _showSuccessMessage(StoreErrorModel(errorMessage: 'Your register successfully',type: 'Status'));

                                            user.clearController();

                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);

                                          }else{

                                            user.loading = false;
                                            stopLoading();

                                            _showErrorMessage(StoreErrorModel(errorMessage: 'Please fill in correctly fill in the email and password field',type: 'Error'));


                                          }
                                        }
                                      },
                                      child: Text(
                                        "Register",
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
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () {
                                  user.clearController();
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LoginScreen()));
                                },
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Do you have a MONEY account?',
                                      style: new TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: FontFamily.latoRegular,
                                          color: Colors.black,
                                          fontSize: 12
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' Login',
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
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }





  // General Methods:-----------------------------------------------------------
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


  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
      confirmedNumber = internationalizedPhoneNumber;
    //  print(phoneIsoCode +" "+ phoneIsoCode  +" "+ confirmedNumber);
    });
  }

}


