class SearchModel{
  bool? status;
  GetSearchData? model;

  SearchModel.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    this.model=GetSearchData.fromjson(json['data']);
  }

}

class GetSearchData{

  int? currentPage;
  List<SearchProducts> data=[];

  GetSearchData.fromjson(Map<String,dynamic> json){
    this.currentPage=json['current_page'];
    json['data'].forEach((element)=>data.add(SearchProducts.fromjson(element)));
  }
}

class SearchProducts{
  int? id;
  dynamic? price;
  String? image;
  String? name;
  SearchProducts.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.price=json["price"];
    this.image=json["image"];
    this.name=json["name"];
  }
}