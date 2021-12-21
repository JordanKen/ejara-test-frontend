import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money/constants/enums.dart';
import 'package:money/core/data/network/http/interfaces/auth/authentification_api_service.dart';
import 'package:money/core/models/user/userModel.dart';
import 'package:money/tools/setup/locator.dart';




class UserProvider with ChangeNotifier {

  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// DECLARATION PUBLIC VARIABLE
  //////////////////
  //////////////////////////////////////////////////////////////////////////////

  AuthentificationApiService _apiService = locator.get<AuthentificationApiService>();

  StatusConnection _status = StatusConnection.Uninitialized;

  UserModel? _userModel;

  bool isUserSignedIn = false;

  bool _loading = true;

  bool _success = false;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();


  List? _userList = <UserModel>[];

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// DECLARATION GETTER ACCESS DATA AND SETTER
  //////////////////
  //////////////////////////////////////////////////////////////////////////////


  StatusConnection get currentStatus => _status;


  set status(StatusConnection value) {
    _status = value;
  }

  UserModel get user => _userModel!;

  set user(UserModel value) {
    _userModel = value;
  }

  List get userList => _userList!;

  UserProvider() {
    //print("init user provider");
  }





  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// MANIPULATION DATA API
  //////////////////
  //////////////////////////////////////////////////////////////////////////////




 Future<bool?> fetchAuthentificationLoginAsync({
    String? email,
    String? password,
  }) async {
    final requestResponse = await _apiService.fetchAuthentificationLoginAsync(email:email , password: password,);
    if (requestResponse!.status == true ) {
      _loading = false;
      _success = true;
      notifyListeners();
      var box = await Hive.openBox('authentification');
      var token = requestResponse.data!['response']['token']['access_token'];
      box.put('token',token );
      print(token);
      return true;
    } else {
      _loading = true;
      _success = false;
      notifyListeners();
      return false;
    }
  }

  Future<UserModel?> fetchAuthentificationRegisterUserAsync({
    String? name,
    String? username,
    String? phone,
    String? email,
    String? password,
    String? avatar,
  }) async {
    final requestResponse = await _apiService.fetchAuthentificationRegisterUserAsync(
      email:email,
      password: password,
      phone:phone,
      name: name,
      avatar: avatar,
      username: username,
    );
    if (requestResponse!.status == true ) {
      _loading = false;
      _success = true;
      notifyListeners();
      UserModel user =  UserModel(email:email, password: password, phone:phone, name: name,username: username);
      return user;
    } else {
      _loading = true;
      _success = false;
      notifyListeners();
    }
  }



  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// MANIPULATION FUNCTION
  //////////////////
  //////////////////////////////////////////////////////////////////////////////


  Future<bool> signIn() async {
    String email = controllerEmail.text.toLowerCase();
    String password = controllerPassword.text;
    try {
      bool? statut = await fetchAuthentificationLoginAsync(email: email,password: password);
      if(statut!){
        _status = StatusConnection.Authenticated;
        notifyListeners();
        return true;
      }else{
        return false;
      }

    } catch (e) {
      _status = StatusConnection.Unauthenticated;
      notifyListeners();
      print(e);
      return false;
    }
    return false;
  }


  Future<bool> signUp() async {
    String email = controllerEmail.text.toLowerCase();
    String password = controllerPassword.text;
    String name = controllerName.text;
    String phone = controllerPhone.text;
    try {
      _userModel = await fetchAuthentificationRegisterUserAsync(
        email: email,
        password: password,
        name:name,
        phone: phone,
        username: name
      );
      if(_userModel! != null){
        _status = StatusConnection.Authenticated;
        notifyListeners();
        return true;
      }else{
        return false;
      }
    } catch (e) {
      _status = StatusConnection.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future<bool> signOut() async {
    _status = StatusConnection.Uninitialized;
    notifyListeners();
    Future.delayed(Duration.zero);
    return true;
  }




  void clearController() {
    controllerPassword.text = "";
    controllerEmail.text = "";
    controllerName.text = "";
    controllerPhone.text = "";
  }


}

