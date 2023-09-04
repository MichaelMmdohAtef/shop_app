import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorite_and_cart_data.dart';
import 'package:shop_app/models/get_carts.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/Categories_screen.dart';
import 'package:shop_app/modules/favorities/favorities_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../models/get_favorites.dart';
import '../../../models/search_model.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{

  ShopAppCubit():super(InitialShopAppStates());

  static ShopAppCubit get(context)=>BlocProvider.of(context);
  HomeModel? homeModel;
  CategoryModelData? categories;
  Map<int?,bool?>? favourites={};
  Map<int?,bool?>? carts={};
  int currentIndex=0;
  GetFavorites? favouriteModel;
  GetCarts? cartModel;
  bool checkHomeModel=false;
  bool checkCategories=false;
  List<Widget> screens=[
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorites"),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
  ];

  onFillHomeOrCategories({bool? homeModelch,bool? categoriesch}){
    this.checkHomeModel=homeModelch!=null?true:this.checkHomeModel;
    this.checkCategories=categoriesch!=null?true:this.checkCategories;
    emit(OnFillHomeOrCategories());
  }

  onChangeCurrentIndex(int index){
    currentIndex=index;
    emit(OnChangeCurrentIndexState());
  }

  getDataModel() {
    emit(OnLoadingGetModelData());
    DioHelper.getData(url: HOME,token: token).then((value) async{

     await changeProductModel(HomeModel.fromjson(value.data));
      this.homeModel!.model!.products.forEach((e) {
        favourites!.addAll({e.id:e.isFavorite});
        carts!.addAll({e.id:e.inCart});
      });
      emit(OnSuccessGetModelData());
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorGetModelData());
    });
  }

  changeProductModel(HomeModel model){
    if(model.status==true) {
      this.homeModel = model;
    }
    emit(OnChangeProductState());
  }

  changeCategoryModel(CategoryModelData model){
    if(model.status==true)
      this.categories=model;
    emit(OnChangeCategoryState());
  }
  getCategories(){
    emit(OnLoadingCategoriesData());
    DioHelper.getData(url: GET_CATEGORIES,token: token).then((value) {

      changeCategoryModel(CategoryModelData.fromjson(value.data));
      print(categories!.model!.data[0]!.name);

      emit(OnSuccessCategoriesData());
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorCategoriesData());
    });
  }
  ChangeFavoriteAndCartData? changeFavoriteData;
  changeFavorites(id){
    favourites![id]= !favourites![id]!;
    emit(OnLoadingChangeFavoritesData());
    DioHelper.postData(url: FAVORITES,data:{"product_id":id} ,token: token).then((value) {
      changeFavoriteData=ChangeFavoriteAndCartData.fromjson(value.data);
      getFavourites();
      emit(OnSuccessChangeFavoritesData(changeFavoriteData));
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorChangeFavoritesData());
    });
  }

  getFavourites(){
    emit(OnLoadingFavouritesData());
    DioHelper.getData(url: FAVORITES,token: token).then((value) {

      favouriteModel=GetFavorites.fromjson(value.data);
      if(favouriteModel!.status==true){
        favouriteModel=favouriteModel;
      }else{
        favouriteModel=null;
      }
      print(favouriteModel!.model!.data![1].products!.id);

      emit(OnSuccessFavouritesData());
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorFavouritesData());
    });
  }

  SearchModel? searchData;
  getSearchItems(String item){
    emit(OnLoadingSearchData());
    DioHelper.postData(url: SEARCH,token: token,data: {
      "text":item
    }).then((value) {

      searchData=SearchModel.fromjson(value.data);
      print(searchData!.model!.data![1].name!);

      // emit(OnSuccessSearchData());
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorSearchData());
    });
  }

  checkIfItemInCart(int id){
    if(carts![id]==true){
      toast(message: "this product is already exist in your cart", status: toastStatus.SUCCESS);
    }else{
      changeCarts(id);
      toast(message: "this product has been added Successfully in your cart", status: toastStatus.SUCCESS);
    }
  }

  ChangeFavoriteAndCartData? changeCartData;
  changeCarts(id){
    emit(OnLoadingChangeFavoritesData());
    DioHelper.postData(url: "carts",data:{"product_id":id} ,token: token).then((value) {
      changeCartData=ChangeFavoriteAndCartData.fromjson(value.data);
      getCarts();
      getDataModel();
      emit(OnSuccessChangeFavoritesData(changeCartData));
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorChangeFavoritesData());
    });
  }

  getCarts(){
    emit(OnLoadingFavouritesData());
    DioHelper.getData(url: "carts",token: token).then((value) {
      cartModel=GetCarts.fromjson(value.data);
      if(cartModel!.status==true){
        cartModel=cartModel;
      }else{
        cartModel=null;
      }
      print(cartModel!.data!.items![1].products!.id);
      emit(OnSuccessFavouritesData());
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorFavouritesData());
    });
  }

}