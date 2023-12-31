import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/states.dart';
import 'package:shop_app/modules/LoginPage/LoginScreen.dart';
import 'package:shop_app/modules/product_cart/product_cart_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Salla"),
            actions: [
              IconButton(
                onPressed: () {
                  CasheHelper.removeData(key: TOKEN);
                  navigateAndFinish(context, LoginScreen());
                },
                icon: Icon(Icons.logout),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {
                      navigateTo(context, ProductCartScreen());
                    },
                    icon: Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  if(cubit.cartModel != null)
                    Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 2,
                      end: 6,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 9,
                      child: Text("${cubit.cartModel!.data!.items!.length}"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (index) {
              cubit.onChangeCurrentIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
