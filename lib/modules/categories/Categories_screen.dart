import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../layouts/shopApp_Layout/cubit/cubit.dart';
import '../../layouts/shopApp_Layout/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: states is !OnLoadingCategoriesData,
            builder: (context) =>
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    productBuilder(cubit.categories!.model!.data[index]),
                separatorBuilder: (context,index) => myDevider(),
                itemCount: cubit.categories!.model!.data.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget productBuilder(CategoryData model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          image: NetworkImage(model!.image!),
          height: 150,
          width: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
