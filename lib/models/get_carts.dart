class GetCarts{
  bool? status;
  GetCartsItems? data;

  GetCarts.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    this.data=GetCartsItems.fromjson(json['data']);
  }

}

class GetCartsItems{

  dynamic total;
  List<CartsDataModel>? items=[];

  GetCartsItems.fromjson(Map<String,dynamic> json){
    this.total=json['total'];
    json['cart_items'].forEach((element)=>items!.add(CartsDataModel.fromjson(element)));
  }
}

class CartsDataModel{

  int? id;
  int? quantity;
  CartsProducts? products;

  CartsDataModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.quantity=json['quantity'];
    products=CartsProducts.fromjson(json['product']);
  }

}
class CartsProducts{

  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images=[];

  CartsProducts.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.price=json["price"];
    this.oldPrice=json["old_price"];
    this.discount=json["discount"];
    this.image=json["image"];
    this.name=json["name"];
    this.description=json["description"];
    json["images"].forEach((element){
      images!.add(element);
    });
  }
}