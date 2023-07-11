import '../shared/components/constants.dart';

class RegisterModel{
  bool? status;
  String? message;
  RegisterDataModel? data;
  RegisterModel.fromJson(Map<String,dynamic> response){
    print(response);
    this.status=response[STATUS];
    this.message=response[MESSAGE];
    this.data=RegisterDataModel.fromJson(response[DATA]);
  }
}
class RegisterDataModel{

  int? id;
  String? name;
  String? email;
  String? phone;
  // String? image;
  String? token;

  RegisterDataModel.fromJson(Map<String,dynamic> data){
    print(data);
    this.id=data[ID];
    this.name=data[NAME];
    this.email=data[EMAIL];
    this.phone=data[PHONE];
    // this.image=data[IMAGE];
    this.token=data[TOKEN];
  }
}