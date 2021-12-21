import 'dart:io';
import 'package:flutter/material.dart';
import 'package:money/core/data/network/http/interfaces/money/money_api_service.dart';
import 'package:money/core/models/bitcoin/bitcoinModel.dart';
import 'package:money/core/models/store/storeErrorModel.dart';
import 'package:money/core/models/tezo/tezosModel.dart';
import 'package:money/tools/setup/locator.dart';



class AppProvider with ChangeNotifier{

  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// DECLARATION PRIVATE VARIABLE
  //////////////////
  //////////////////////////////////////////////////////////////////////////////

  MoneyApiService _apiService = locator.get<MoneyApiService>();


  bool _loading = true;

  bool _success = false;

  List<BitcoinModel>? _bitcoinList = <BitcoinModel>[];

  BitcoinModel? _bitcoinModel;

  List<TezosModel>? _tezosList = <TezosModel>[];

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  List<TezosModel>? get tezosList => _tezosList;

  List<BitcoinModel>? get bitcoinList => _bitcoinList;


  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// DECLARATION GETTER ACCESS DATA
  //////////////////
  //////////////////////////////////////////////////////////////////////////////



  AppProvider() {
    print("init app provider");

  }


  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// MANIPULATION DATA API
  //////////////////
  //////////////////////////////////////////////////////////////////////////////


  Future<List<BitcoinModel>?> fetchMoneyBitcoinsAsync() async {

    final future = _apiService.fetchMoneyBitcoinsAsync();

    future.then((requestResponse) {
      if (requestResponse!.status == true ) {
        _loading = false;
        _success = true;
        notifyListeners();
        StoreErrorModel socketError = StoreErrorModel(type: "API", errorMessage: requestResponse.message );
        print(socketError.toString());


        _bitcoinList = List<BitcoinModel>.from((requestResponse.data!['tx'] as List).map((model){
         // print(model);
          return BitcoinModel(
            size: model["size"],
            block_height: model["block_height"],
            weight: model["weight"],
            double_spend: model["double_spend"],
            fee: model["fee"],
            relayed_by: model["relayed_by"],
            vout_sz: model["vout_sz"],
            vin_sz: model["vin_sz"],
            ver: model["ver"],
            hash: model["hash"],
            time: model["time"],
            block_index: model["block_index"],
            out: List.from(model["out"]),
            inputs: List.from(model["inputs"]),
            lock_time: model["lock_time"],
            tx_index: model["tx_index"],

          );
          //BitcoinModel.fromJson(model)
        })).toList();

       // print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
        //print(_bitcoinList!.first);

        return _bitcoinList!;

      } else {
        _loading = true;
        _success = false;
        notifyListeners();
        StoreErrorModel socketError = StoreErrorModel(type: "API", errorMessage: requestResponse.message );
        print(socketError.toString());
        return _bitcoinList = null;
      }

    }).catchError((error) {
      _loading = false;
      _success = false;
      notifyListeners();
      switch (error.runtimeType){
        case HttpException: {
          StoreErrorModel socketError = StoreErrorModel(type: "NETWORK", errorMessage: error.message );
          print(socketError.toString());
        }
        break;
        case SocketException: {
          StoreErrorModel socketError = StoreErrorModel(type: "NETWORK", errorMessage: error.message );
          print(socketError.toString());
        }
        break;
      }
    });
  }


  /*Future<List<BitcoinModel>?> fetchMoneyBitcoinsAsync() async {

    final future = _apiService.fetchMoneyBitcoinsAsync();

    future.then((requestResponse) {
      if (requestResponse!.status == true ) {
        _loading = false;
        _success = true;
        notifyListeners();
       // print(requestResponse.data);
        // ToDO

        StoreErrorModel socketError = StoreErrorModel(type: "API", errorMessage: requestResponse.message );
        print(socketError.toString());
        //_userList=(requestResponse.data!["users"] as List).map((i) => UserModel.fromJson(i)).toList();

         //_bitcoinList = List<BitcoinModel>.from((requestResponse.data!).map((model)=> BitcoinModel.fromJson(model))).toList();
         print("///////////////////////////////////////////////////////////////////////////////////////");
         print(_bitcoinList);
        return _bitcoinList;

      } else {
        _loading = true;
        _success = false;
        notifyListeners();
        StoreErrorModel socketError = StoreErrorModel(type: "API", errorMessage: requestResponse.message );
        print(socketError.toString());
        return _bitcoinList = null;
      }

    }).catchError((error) {
      _loading = false;
      _success = false;
      notifyListeners();
      switch (error.runtimeType){
        case HttpException: {
          StoreErrorModel socketError = StoreErrorModel(type: "NETWORK", errorMessage: error.message );
          print(socketError.toString());
        }
        break;
        case SocketException: {
          StoreErrorModel socketError = StoreErrorModel(type: "NETWORK", errorMessage: error.message );
          print(socketError.toString());
        }
        break;
      }
    });
  }*/

  Future<List<TezosModel>?> fetchMoneyTezosAsync() async {

    final future = _apiService.fetchMoneyTezosAsync();

    future.then((requestResponse) {
      if (requestResponse!.status == true ) {
        _loading = false;
        _success = true;
        notifyListeners();
        print(requestResponse.data);

        StoreErrorModel socketError = StoreErrorModel(type: "API", errorMessage: requestResponse.message );
        print(socketError.toString());

        return _tezosList = List<TezosModel>.from((requestResponse.data! as List).map((model)=>TezosModel.fromJson(model))).toList();

      } else {
        _loading = true;
        _success = false;
        notifyListeners();
        StoreErrorModel socketError = StoreErrorModel(type: "API", errorMessage: requestResponse.message );
        print(socketError.toString());
        return _tezosList = null;
      }

    }).catchError((error) {
      _loading = false;
      _success = false;
      notifyListeners();
      switch (error.runtimeType){
        case HttpException: {
          StoreErrorModel socketError = StoreErrorModel(type: "NETWORK", errorMessage: error.message );
          print(socketError.toString());
        }
        break;
        case SocketException: {
          StoreErrorModel socketError = StoreErrorModel(type: "NETWORK", errorMessage: error.message );
          print(socketError.toString());
        }
        break;
      }
    });
  }



/////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// MANIPULATION METHODE
  //////////////////
  //////////////////////////////////////////////////////////////////////////////


}
