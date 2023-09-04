class ChangeFavoriteAndCartData{

  bool? status;
  String? message;

  ChangeFavoriteAndCartData.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    this.message=json['message'];
  }
}