import '../../../models/change_favorite_and_cart_data.dart';

abstract class ShopAppStates{}

class InitialShopAppStates extends ShopAppStates{}
class OnChangeCurrentIndexState extends ShopAppStates{}
class OnChangeCategoryState extends ShopAppStates{}
class OnChangeProductState extends ShopAppStates{}

class OnLoadingGetModelData extends ShopAppStates{}
class OnSuccessGetModelData extends ShopAppStates{}
class OnErrorGetModelData extends ShopAppStates{}


class OnLoadingCategoriesData extends ShopAppStates{}
class OnSuccessCategoriesData extends ShopAppStates{}
class OnErrorCategoriesData extends ShopAppStates{}

class OnLoadingChangeFavoritesData extends ShopAppStates{}
class OnSuccessChangeFavoritesData extends ShopAppStates{
  ChangeFavoriteAndCartData? model;
  OnSuccessChangeFavoritesData(this.model);
}
class OnErrorChangeFavoritesData extends ShopAppStates{}

class OnLoadingFavouritesData extends ShopAppStates{}
class OnSuccessFavouritesData extends ShopAppStates{}
class OnErrorFavouritesData extends ShopAppStates{}

class OnLoadingSearchData extends ShopAppStates{}
class OnSuccessSearchData extends ShopAppStates{}
class OnErrorSearchData extends ShopAppStates{}


class OnFillHomeOrCategories extends ShopAppStates{}

class OnLoadingChangeCartsData extends ShopAppStates{}
class OnSuccessChangeCartsData extends ShopAppStates{
  ChangeFavoriteAndCartData? model;
  OnSuccessChangeCartsData(this.model);
}
class OnErrorChangeCartsData extends ShopAppStates{}

class OnLoadingGetCartsData extends ShopAppStates{}
class OnSuccessGetCartsData extends ShopAppStates{}
class OnErrorGetCartsData extends ShopAppStates{}

class OnLoadingUpdateCartsData extends ShopAppStates{}
class OnSuccessUpdateCartsData extends ShopAppStates{}
class OnErrorUpdateCartsData extends ShopAppStates{}

class OnLoadingRemoveCartsData extends ShopAppStates{}
class OnSuccessRemoveCartsData extends ShopAppStates{}
class OnErrorRemoveCartsData extends ShopAppStates{}


class OnEnlargeQuantity extends ShopAppStates{}
class OnMinimizeQuantity extends ShopAppStates{}
