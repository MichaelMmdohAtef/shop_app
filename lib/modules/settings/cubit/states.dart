import 'package:shop_app/models/shop_login_data.dart';

abstract class SettingStates{}

class InitialProfileStates extends SettingStates{}

class OnChangeVisipilityPassword extends SettingStates{}


class SocialLoadingProfileState extends SettingStates{}
class SocialSuccessProfileState extends SettingStates{
  ShopLoginData? registerModel;
  SocialSuccessProfileState(this.registerModel);
}
class SocialErrorProfileState extends SettingStates{
  final String error;
  SocialErrorProfileState(this.error);
}

class SocialLoadingUpdatedProfileState extends SettingStates{}
class SocialSuccessUpdatedProfileState extends SettingStates{
  ShopLoginData? profileModel;
  SocialSuccessUpdatedProfileState(this.profileModel);
}
class SocialErrorUpdatedProfileState extends SettingStates{
  final String error;
  SocialErrorUpdatedProfileState(this.error);
}



