import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_data.dart';
import 'package:shop_app/modules/LoginPage/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';


class LoginCubit extends Cubit<LoginStates> {

  LoginCubit():super(InitialLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword=true;
  ShopLoginData? loginData;

  var id;


  Future LoginAccount({
    required TextEditingController emailController,
    required TextEditingController passWordController,
  }) async{
    emit(SocialLoginLoadingState());
    DioHelper.postData(url: LOGIN, data:{
      "email":emailController.text.trim(),
      "password":passWordController.text,
    }).then((value){
      loginData=ShopLoginData.fromJson(value.data);
      emit(SocialLoginSuccessState(loginData!));
      emailController.clear();
      passWordController.clear();
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLoginErrorState(onError.toString()));
    });
  }


  onChangePassword(){
    isPassword=!isPassword;
    emit(OnChangeVisipilityOfPass());
  }



}