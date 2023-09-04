import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/states.dart';
import 'package:shop_app/models/get_carts.dart';

class ProductCartScreen extends StatelessWidget {
  ProductCartScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        GetCarts? model = cubit.cartModel;
        return Scaffold(
          appBar: AppBar(
            title: Text("My Shoping Cart"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  if (cubit.cartModel!.data!.items != null)
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
          body: ConditionalBuilder(
            condition: model != null,
            builder: (context) => itemOfCart(model!.data!.items![1]),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget itemOfCart(CartsDataModel model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Dismissible(
        onDismissed: (value){
          
        },
        background: Container(
          color: Colors.red,
          child: IconButton(
            onPressed: (){},
            icon: Icon(Icons.delete,
            size: 25,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        key:ValueKey<int>(model.id!),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  model.products!.image!,
                ),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          "Name: ",
                          style: TextStyle(
                            color: Colors.blue,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          "${model.products!.name}",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            height: 1.5,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Price: ",
                          style: TextStyle(height: 1.5, color: Colors.blue),
                        ),
                        Text(
                          "${model.products!.price}",
                          style: TextStyle(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Old Price: ",
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "${model.products!.oldPrice}",
                          style: TextStyle(
                            height: 1.5,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 10,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.add,
                                    size: 13,
                                    color: Colors.black,
                                  )),
                            ),
                            SizedBox(width: 5,),
                            Text("${model!.quantity!}"),
                            SizedBox(width: 5,),
                            CircleAvatar(
                              maxRadius: 10,
                              backgroundColor: Colors.blue,
                              child: Center(
                                child: IconButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.only(
                                      bottom: 60,
                                    ),
                                    icon: Icon(
                                      Icons.minimize_sharp,
                                      size: 13,
                                      color: Colors.black,
                                    )),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
