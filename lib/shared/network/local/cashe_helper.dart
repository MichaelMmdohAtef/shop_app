
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper{

  static SharedPreferences? sharedPreferences;

  static init() async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static Future<bool> setString({
    required String key,
    required dynamic value,
  })async{
    return await sharedPreferences!.setString(key, value);
  }

  static Future<bool> setBoolean({
    required String key,
    required dynamic value,
  })async{
    return await sharedPreferences!.setBool(key, value);
  }


  static dynamic getData({
    required String key,
  })async{
    return await sharedPreferences!.get(key);
  }

  static dynamic removeData({
    required String key,
  }){
    return sharedPreferences!.remove(key);
  }

}