
import '../../../models/shop_register_data.dart';

abstract class RegisterStates{}

class InitialRegisterStates extends RegisterStates{}

class OnChangeVisipilityOfPass extends RegisterStates{}

class SocialRegisterLoadingState extends RegisterStates{}
class SocialRegisterSuccessState extends RegisterStates{
  RegisterModel? registerModel;
  SocialRegisterSuccessState(this.registerModel);
}
class SocialRegisterErrorState extends RegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}



