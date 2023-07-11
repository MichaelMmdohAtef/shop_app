

import 'package:shop_app/models/shop_login_data.dart';

abstract class LoginStates{}

class InitialLoginStates extends LoginStates{}

class OnChangeVisipilityOfPass extends LoginStates{}

class SocialLoginLoadingState extends LoginStates{}
class SocialLoginSuccessState extends LoginStates{
  ShopLoginData loginData;
  SocialLoginSuccessState(this.loginData);
}
class SocialLoginErrorState extends LoginStates{
  final String error;
  SocialLoginErrorState(this.error);

}
class SocialLoginSuuccessState extends LoginStates {
}




