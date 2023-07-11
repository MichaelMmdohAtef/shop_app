import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/states.dart';
import 'package:shop_app/modules/LoginPage/LoginScreen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener:(context,states){},
      builder:(context,states){

          var cubit=ShopAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Salla"),
              actions: [
                IconButton(onPressed: (){
                  CasheHelper.removeData(key: TOKEN);
                  navigateAndFinish(context, LoginScreen());
                }, icon: Icon(Icons.logout),),
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search),)
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              onTap: (index){
                cubit.onChangeCurrentIndex(index);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
      },
    );

  }
}
