class ChangeFavoriteData{

  bool? status;
  String? message;

  ChangeFavoriteData.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    this.message=json['message'];
  }


}