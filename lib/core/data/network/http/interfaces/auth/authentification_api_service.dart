
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:money/core/data/network/converters/wrapped_map_response.dart';
import '../../api_url.dart';

class AuthentificationApiService {

  /*
  Execute a POST request for logout to user
   */

  Future<WrappedMapResponse?> fetchAuthentificationLogoutAsync({String? user_id}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Uri url =  Uri.parse('${ApiUrl.BASE_URL}/logout/$user_id');

    WrappedMapResponse response = new WrappedMapResponse();

    try {

      var data = {'user_id': user_id,};

      var dataJson = json.encode(data);

      http.Response convert_response = await http.post(url, headers: headers,body: dataJson );

      var jsonBody = json.decode(convert_response.body);

      if(jsonBody != null){
        response.status = true;
        response.data = jsonBody;
        response.message = "Success";
        return response;
      }else{
        response.status = false;
        response.data = jsonBody;
        response.message = "Failed";
        return response;
      }
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }


  /**
   * Execute a POST request for sign-up to user
   */

  Future<WrappedMapResponse?> fetchAuthentificationRegisterUserAsync({
    String? name,
    String? username,
    String? phone,
    String? email,
    String? avatar,
    String? password,
  }) async {

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Uri url = Uri.parse('${ApiUrl.BASE_URL}auth/users/register');

    var data = {
      'name': name,
      'username' : username,
      'phone': phone,
      'email': email,
      'password' : password,
      'avatar' : avatar
    };

    var dataJson = json.encode(data);

    WrappedMapResponse response = new WrappedMapResponse();

    try {
      final convert_response = await http.post(url, headers: headers, body: dataJson);

      final jsonBody = jsonDecode(convert_response.body);

      if(jsonBody != null){
        response.status = true;
        response.data = jsonBody;
        response.message = "200";
        return response;
      }else{
        response.status = false;
        response.data = null;
        response.message = "201";
        return response;
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }



  /* Execute a POST request for login to user
   */

  Future<WrappedMapResponse?> fetchAuthentificationLoginAsync({
    String? email,
    String? password,
  }) async {

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Uri url =  Uri.parse('${ApiUrl.BASE_URL}auth/users/login');

    var data = {
      'email': email,
      'password': password,
    };

    var dataJson = json.encode(data);

    WrappedMapResponse response = new WrappedMapResponse();

    try {
      final convert_response = await http.post(url, headers: headers, body: dataJson);

      final jsonBody = jsonDecode(convert_response.body);

      if(jsonBody != null){
        response.status = true;
        response.data = jsonBody;
        response.message = "200";
        return response;
      }else{
        response.status = false;
        response.data = null;
        response.message = "201";
        return response;
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }

}
