import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/shop_login_data.dart';

class HomeModel{

  bool? status;
  DataModel? model;

  HomeModel();
  HomeModel.fromjson(Map<String,dynamic> json){
    this.status=json["status"];
    this.model=DataModel.fromjson(json["data"]);
  }
}

class DataModel{
  List<BannersModel> banners=[];
  List<ProductModel> products=[];
  // Map<String,dynamic> banners={};
  // Map<String,dynamic> products={};
  DataModel.fromjson(Map<String,dynamic> data){

    data["banners"].forEach((element){
      this.banners.add(BannersModel(element));
    });
    data["products"].forEach((element){
      this.products.add(ProductModel(element));
    });

  }
}
class BannersModel{
  int? id;
  String? image;


  BannersModel(Map<String,dynamic> banners){
    this.id=banners["id"];
    this.image=banners["image"];
  }
}

class ProductModel{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<String> images=[];
  bool? isFavorite;
  bool? inCart;


  ProductModel(Map<String,dynamic> products){
    this.id=products['id'];
    this.price=products["price"];
    this.oldPrice=products["old_price"];
    this.discount=products["discount"];
    this.image=products["image"];
    this.name=products["name"];
    this.description=products['description'];
    products['images'].forEach((element){
      images.add(element);
    });
    this.isFavorite=products["in_favorites"];
    this.inCart=products["in_cart"];
  }

}