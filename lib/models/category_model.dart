import 'package:flutter/foundation.dart';
import 'package:shop_app/models/shop_login_data.dart';

class CategoryModelData{

  bool? status;
  CategoryDataModel? model;

  CategoryModelData();

  CategoryModelData.fromjson(Map<String,dynamic> json){
    this.status=json["status"];
    print(this.status);
    this.model=CategoryDataModel.fromjson(json["data"]);
  }
}

class CategoryDataModel{
  int? currentPage;
  List<CategoryData> data=[];

  CategoryDataModel.fromjson(Map<String,dynamic> json){
    this.currentPage=json["current_page"];
    print(this.currentPage);
    json["data"].forEach((element){
      this.data.add(CategoryData(element));
    });
  }

}

class CategoryData{
  String? name;
  String? image;

  CategoryData(Map<String,dynamic> category){
    this.name=category["name"];
    print(this.name);
    this.image=category["image"];
  }
}
