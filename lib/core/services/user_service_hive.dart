import 'package:hive/hive.dart';
import 'package:money/core/data/local/db_constants.dart';
import 'package:money/core/models/user/userModel.dart';

class UserServiceHive{


  //////////////////////////////////////////////////////////////////////////////
  ////////////////////
  /////////////////// MANIPULATION DATA HIVE (LOCAL DATABASE)
  //////////////////
  //////////////////////////////////////////////////////////////////////////////


  addUser(UserModel userModel) async {

    var box = await Hive.openBox<UserModel>(DBConstants.USER_STORE_NAME);

    int index = await box.add(userModel);

    getUserById(index);

  }

  getUsers() async{

    final box = await Hive.openBox<UserModel>(DBConstants.USER_STORE_NAME);

    return box.values.toList();

  }

  updateUser(int index, UserModel userModel) {

    final box = Hive.box<UserModel>(DBConstants.USER_STORE_NAME);

    box.putAt(index, userModel);
  }

  deleteUser(int index) {

    final box = Hive.box<UserModel>(DBConstants.USER_STORE_NAME);

    box.deleteAt(index);
  }

  getUserById(int index)async{

    final box = await Hive.openBox<UserModel>(DBConstants.USER_STORE_NAME);

    return box.getAt(index)!;

  }
}