import 'package:dio/dio.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio=Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
      // headers: {
      //     "Content-Type":"application/json",
      // }
    ),
    );
  }
  
  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
    String? token,
    String? language="en",
})async{
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":language,
      "Authorization":token??null,
    };
   return await dio!.post(url,data:data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String,dynamic> data,
    String? token,
    String? language="en",
  })async{
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":language,
      "Authorization":token??null,
    };
    return await dio!.put(url,data:data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map? data,
    String? token,
    String? language="en",
  })async{
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":language,
      "Authorization":token??null,
    };
    return await dio!.get(url,queryParameters:query);
  }



}
