
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
  Map<int?,int?>? quantities={};
  int currentIndex=0;
  GetFavorites? favouriteModel;
  GetCarts? cartModel;
  bool checkHomeModel=false;
  bool checkCategories=false;
  List<Widget> screens=[
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorites"),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
  ];

  onFillHomeOrCategories({bool? homeModelCh,bool? categoriesCh}){
    this.checkHomeModel=homeModelCh!=null?true:this.checkHomeModel;
    this.checkCategories=categoriesCh!=null?true:this.checkCategories;
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
  getSearchItems(String item)async{
    emit(OnLoadingSearchData());
   await DioHelper.postData(url: SEARCH,token: token,data: {
      "text":item
    }).then((value) {
      searchData=SearchModel.fromjson(value.data);
      print(searchData!.model!.data![1].name!);
      emit(OnSuccessSearchData());
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
 Future changeCarts(id) async{
    emit(OnLoadingChangeCartsData());
   await DioHelper.postData(url: "carts",data:{"product_id":id} ,token: token).then((value) {
      changeCartData=ChangeFavoriteAndCartData.fromjson(value.data);
      getCarts();
      getDataModel();
      emit(OnSuccessChangeCartsData(changeCartData));
    }).catchError((onError){
      print(onError.toString());
      emit(OnErrorChangeCartsData());
    });
  }

   getCarts() async{
    emit(OnLoadingGetCartsData());
   await DioHelper.getData(url: "carts",token: token).then((value) {
      cartModel=GetCarts.fromjson(value.data);
      if(cartModel!.status==true){
        cartModel=cartModel;
        cartModel!.data!.items!.forEach((element) {
          quantities!.addAll({element.id:element.quantity});
        });
      }else{
        cartModel=null;
      }
      print(cartModel!.data!.items![1].products!.id);
      emit(OnSuccessGetCartsData());
    }).catchError((onError){
      print("${onError.toString()}");
      emit(OnErrorGetCartsData());
    });
   quantities!.forEach((key, value) {
     print("id: ${key} \n quantity: ${value}");
   });
  }

  enlargeQuantity(int id){
   quantities!.forEach((key, value) {
     if(key == id){
       quantities![key]=value! + 1 ;
     }
   });
   // getCarts();
   emit(OnEnlargeQuantity());
  }

  minimizeQuantity(int id){
    quantities!.forEach((key, value) {
      if(key == id){
        quantities![key]=value! - 1 ;
      }
    });
    // getCarts();
    emit(OnMinimizeQuantity());
  }

// GetCarts? updateCart;
//   updateCarts(){
//     emit(OnLoadingGetCartsData());
//     DioHelper.putData(url: "carts/3",token: token,data: {
//       "quantity":"3",
//       "product_id":"55"
//     }).then((value) {
//       updateCart=GetCarts.fromjson(value.data);
//       if(cartModel!.status==true){
//         updateCart=updateCart;
//       }else{
//         updateCart=null;
//       }
//       print(updateCart!.data!.items![1].quantity);
//       emit(OnSuccessGetCartsData());
//     }).catchError((onError){
//       print(onError.toString());
//       emit(OnErrorGetCartsData());
//     });
//   }



  removeProductFromCart(int id,int index)async{
      cartModel!.data!.items!.removeAt(index);
      emit(OnLoadingRemoveCartsData());
     await changeCarts(id).then((value){
        toast(message: "this product Removed Successfully from your cart", status: toastStatus.SUCCESS);
        emit(OnSuccessRemoveCartsData());
      }).catchError((onError){
        toast(message: onError.toString(), status: toastStatus.ERROR);
        emit(OnErrorRemoveCartsData());
      });

  }


}