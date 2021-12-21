
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money/core/data/network/converters/wrapped_list_response.dart';
import 'package:money/core/data/network/converters/wrapped_map_response.dart';
import '../../api_url.dart';

class MoneyApiService {

  /**
   * Execute a Get request all bitcoin
   */

  Future<WrappedMapResponse?> fetchMoneyBitcoinsAsync() async {

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Uri url = Uri.parse('${ApiUrl.BASE_URL}bitcoin');

    WrappedMapResponse response = new WrappedMapResponse();

    try {
      http.Response convert_response =  await http.get(url, headers: headers);

      //print(convert_response.body.toString());

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
   * Execute a Get request all tezos
   */

  Future<WrappedListResponse?> fetchMoneyTezosAsync() async {

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Uri url = Uri.parse('${ApiUrl.BASE_URL}tezos');

    WrappedListResponse response = new WrappedListResponse();

    try {
     http.Response convert_response =  await http.get(url, headers: headers);

      print(convert_response.body.toString());
     /* late http.Response convert_response;
      http.get(url,headers: headers).then((value) {
        print(value.body.toString());
        convert_response = value;
        return value;
      });*/

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

}
