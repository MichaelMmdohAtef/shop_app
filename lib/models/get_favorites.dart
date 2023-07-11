class GetFavorites{
  bool? status;
  GetFavoriteData? model;

  GetFavorites.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    this.model=GetFavoriteData.fromjson(json['data']);
  }

}

class GetFavoriteData{

  int? currentPage;
  List<FavoritesDataModel> data=[];

  GetFavoriteData.fromjson(Map<String,dynamic> json){
    this.currentPage=json['current_page'];
    json['data'].forEach((element)=>data.add(FavoritesDataModel.fromjson(element)));
  }
}

class FavoritesDataModel{

  int? id;
  FavouritProducts? products;
  FavoritesDataModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    products=FavouritProducts.fromjson(json['product']);
  }


}
class FavouritProducts{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  FavouritProducts.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.price=json["price"];
    this.oldPrice=json["old_price"];
    this.discount=json["discount"];
    this.image=json["image"];
    this.name=json["name"];
  }
}