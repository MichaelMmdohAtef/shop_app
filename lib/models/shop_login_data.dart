import 'package:shop_app/shared/components/constants.dart';

class ShopLoginData{
  bool? status;
  String? message;
  DataModel? data;
  ShopLoginData.fromJson(Map<String,dynamic> response){
    print(response);
    this.status=response[STATUS];
    this.message=response[MESSAGE];
    this.data=DataModel.fromJson(response[DATA]);
  }
}

class DataModel{

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credits;
  String? token;

  DataModel.fromJson(Map<String,dynamic> data){
    this.id=data[ID];
    this.name=data[NAME];
    this.email=data[EMAIL];
    this.phone=data[PHONE];
    this.image=data[IMAGE];
    this.points=data[POINTS];
    this.credits=data[CREDIT];
    this.token=data[TOKEN];
  }

}