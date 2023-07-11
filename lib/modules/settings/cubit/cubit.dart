
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../../models/shop_login_data.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import '../../RegisterScreen/cubit/states.dart';

class SettingCubit extends Cubit<SettingStates> {

  SettingCubit():super(InitialProfileStates());

  static SettingCubit get(context) => BlocProvider.of(context);
  ShopLoginData? profileModel;


  Future getProfileData() async{
    emit(SocialLoadingProfileState());
    DioHelper.getData(url: PROFILE,token: token,)
        .then((value){
      profileModel=ShopLoginData.fromJson(value.data);
      emit(SocialSuccessProfileState(profileModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(SocialErrorProfileState(onError.toString()));
    });
  }

  Future updateProfileData({
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) async{
    emit(SocialLoadingUpdatedProfileState());
    DioHelper.putData(url: UPDATE,token: token, data: {
      "name":nameController.text,
      "email":profileModel!.data!.email,
      "phone":phoneController.text,
    }).then((value){
      profileModel=ShopLoginData.fromJson(value.data);
      emit(SocialSuccessUpdatedProfileState(profileModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(SocialErrorUpdatedProfileState(onError.toString()));
    });
  }

}