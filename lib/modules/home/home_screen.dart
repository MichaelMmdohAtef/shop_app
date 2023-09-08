
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:toast/toast.dart';
import '../../layouts/shopApp_Layout/cubit/cubit.dart';
import '../../layouts/shopApp_Layout/cubit/states.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();


   changeVariables(BuildContext context,ShopAppCubit cubit)async{
     if(ShopAppCubit.get(context).homeModel!=null) {
      cubit.onFillHomeOrCategories(homeModelCh: true);
    }

    if(ShopAppCubit.get(context).categories!=null) {
      cubit.onFillHomeOrCategories(categoriesCh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener:(context,states){
        if(states is OnSuccessChangeFavoritesData){
          states.model!.status!?toast(message:states.model!.message!,status:toastStatus.SUCCESS):
          toast(message:states.model!.message!,status:toastStatus.ERROR);
        }
      } ,
      builder:(context,states){
        var cubit=ShopAppCubit.get(context);
        changeVariables(context,cubit);
        ToastContext().init(context);

        return Scaffold(
          body:ConditionalBuilder(
              condition:cubit.checkHomeModel && cubit.checkCategories,
              builder:(context)=> productBuilder(cubit.homeModel!,cubit.categories!,context),
          fallback:(context)=>Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
  Widget productBuilder(HomeModel homeData,CategoryModelData category,BuildContext context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    CarouselSlider(
        items:homeData.model!.banners.map((e)=>
    Image(
    image: NetworkImage(e.image!),
    width: double.infinity,
    fit: BoxFit.cover,
    ),
    ).toList(),
    options: CarouselOptions(
    height: 200,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 4),
    autoPlayAnimationDuration: Duration(seconds: 2),
    autoPlayCurve: Curves.fastOutSlowIn,
    // animateToClosest:true,
    initialPage:0,
    scrollDirection: Axis.horizontal,
    viewportFraction: 1,
    // scrollPhysics: BouncingScrollPhysics(),
    )),
    SizedBox(
        height: 15,
      ),
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 1.2,
          ),
          ),
            SizedBox(
              height: 30,
            ),
          Container(
            height: 130,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=>categoryItem(category.model!.data[index]),
                separatorBuilder: (context,index)=>SizedBox(width: 5,),
                itemCount: category.model!.data.length),
          ),
            SizedBox(
              height: 40,
            ),
            Text("Products",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1.2,
              ),
            ),
        ],
      ),
    ),
   SizedBox(
        height: 30,
      ),
    Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.52,
        children: List.generate(homeData!.model!.products!.length,
                  (index)=>productItem(homeData.model!.products[index],context,isFavourite: true),

        ),
      ),
    ),
    ],
    ),
  );

   Widget categoryItem(CategoryData? category)=>Stack(
     alignment: AlignmentDirectional.bottomCenter,
     children: [
       Image(image: NetworkImage(category!.image!),
         height: double.infinity,
         width: 150,
         fit: BoxFit.cover,
       ),
       Container(
         width: 150,
         color: Colors.black.withOpacity(0.8),
         child: Text(category.name!,
           overflow: TextOverflow.ellipsis,
           maxLines: 1,
           style: TextStyle(
             color: Colors.white,
             fontSize: 25,
             fontWeight: FontWeight.bold,

           ),
           textAlign: TextAlign.center,
         ),
       ),
     ],
   );

  // Widget productItem(ProductModel? model,BuildContext context)=>Container(
  //   color: Colors.white,
  //   child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Stack(
  //         alignment: AlignmentDirectional.bottomStart,
  //         children: [
  //           Image(image: NetworkImage(model!.image!),
  //           height: 200,
  //           width: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //           if(model.discount!=0)
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 5.0),
  //             child: Text("Discount",
  //             textAlign: TextAlign.end,
  //             style: TextStyle(
  //               backgroundColor: Colors.red,
  //               color: Colors.white,
  //             ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               model.name!,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 height: 1.3,
  //               ),
  //             ),
  //             Row(
  //                 children: [
  //                   Text(
  //                     "${model.price!}",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.blue,
  //                     ),
  //                   ),
  //                   SizedBox(width: 10,),
  //                   if(model.discount!=0)
  //                     Text(
  //                     "${model.oldPrice!}",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey,
  //                       decoration: TextDecoration.lineThrough,
  //                     ),
  //                   ),
  //                   Spacer(),
  //                   IconButton(onPressed: (){
  //                     ShopAppCubit.get(context).changeFavorites(model.id);
  //                   }, icon: CircleAvatar(
  //                     backgroundColor:ShopAppCubit.get(context).favorities![model.id]==true? Colors.blueAccent:Colors.grey,
  //                       child: Icon(Icons.favorite_border,
  //                       color: Colors.white,
  //                       ),),)
  //                 ]
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  // );

}

