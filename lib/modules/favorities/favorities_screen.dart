import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorites.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../layouts/shopApp_Layout/cubit/cubit.dart';
import '../../layouts/shopApp_Layout/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener:(context,states){} ,
      builder:(context,states){
        var cubit=ShopAppCubit.get(context);
        return Scaffold(
          body:ConditionalBuilder(
              condition: cubit.favouriteModel!=null,
              builder: (context)=>ListView.separated(
                  itemBuilder: (context,index)=>productItem(cubit.favouriteModel!.model!.data[index].products,context),
                  separatorBuilder:(context,index)=>myDevider(),
                  itemCount: cubit.favouriteModel!.model!.data.length),
              fallback:(context)=>Center(child: Text("No Favorites Exist",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: "shortBaby"
              ),
              ),))


        );
      },
    );
  }
  Widget productItem(FavouritProducts? model,BuildContext context)=>Container(
    width: double.infinity,
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model!.image!),
              height: 120,
              width: 150,
              fit: BoxFit.fill,
            ),
            if(model.discount!=0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text("Discount",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                    children: [
                      Text(
                        "${model.price!} \$",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10,),
                      if(model.discount!=0)
                        Text(
                          "${model.oldPrice!} \$",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(onPressed: (){
                        ShopAppCubit.get(context).changeFavorites(model.id);
                      }, icon: CircleAvatar(
                        backgroundColor:ShopAppCubit.get(context).favourites![model.id]==true? Colors.blueAccent:Colors.grey,
                        child: Icon(Icons.favorite_border,
                          color: Colors.white,
                        ),),)
                    ]
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
