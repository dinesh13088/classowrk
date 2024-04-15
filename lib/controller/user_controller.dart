
import 'package:classwork/model/user_model.dart';
import 'package:classwork/services/firebase_database_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{
  var userModel = UserModel().obs;
  var uId = "".obs;
  final databaseService = FirebaseDatabaseService();

  @override
    void onReady() {
      initSharedPreferences();
      super.onReady();
    }

  void initSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      uId.value = prefs.getString('uId') ?? '';

      getUserDetailsUsingUID();
  }
  // function to get userDetails using uId
  getUserDetailsUsingUID() async {
    UserModel? userDetails;
    userDetails = await databaseService.getUserDetailsUsingUID(uId: uId.value);
    if(userDetails!=null){
      userModel.value = userDetails;
    }
  }

}