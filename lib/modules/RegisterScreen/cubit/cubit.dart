

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shopApp_Layout/shop_layout.dart';
import 'package:shop_app/models/shop_register_data.dart';
import 'package:shop_app/modules/RegisterScreen/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';



class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit():super(InitialRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;
  bool isPassword=true;
  var id;


registerAccount({
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController phoneController,
  required TextEditingController passWordController,
  required TextEditingController confirmPassWordController,
}) async{
  emit(SocialRegisterLoadingState());
  // await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: emailController.text.trim(),
  //     password: passWordController.text)
  //     .then((value){
  //       emit(SocialRegisterSuccessState());
  //   id=value.user!.uid;
  //   print(id);
  //   emailController.clear();
  //   passWordController.clear();
  //   confirmPassWordController.clear();
  // }).catchError((onError){
  //   emit(SocialRegisterErrorState(onError.toString()));
  //   print(onError.toString());
  // });
  DioHelper.postData(url: REGISTER, data: {
    "name":nameController.text,
    "email":emailController.text.trim(),
    "password":passWordController.text,
    "phone":phoneController.text,
  },).then((value){
    registerModel=RegisterModel.fromJson(value.data);
    token=registerModel!.data!.token;
    CasheHelper.setString(key: TOKEN, value: token);
    emit(SocialRegisterSuccessState(this.registerModel));
    print(value.data.toString());
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passWordController.clear();
    confirmPassWordController.clear();
  }).catchError((onError){
    print(onError.toString());
    emit(SocialRegisterErrorState(onError.toString()));
  });
}

  onChangePassword(){
    isPassword=!isPassword;
    emit(OnChangeVisipilityOfPass());
  }




}