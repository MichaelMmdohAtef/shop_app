import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorites.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../layouts/shopApp_Layout/cubit/cubit.dart';
import '../../layouts/shopApp_Layout/cubit/states.dart';
import '../../models/search_model.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: defaultFormField(
                      controller: searchController,
                      label:"Search",
                    hint: "please enter item which you need",
                    onValidate: (value){
                      if(value!.isEmpty){
                        return "this field can not be empty";
                      }
                      return null;
                    },
                      onFieldSubmitted: (value){
                        cubit.getSearchItems(value);
                      },
                    prefixIcon: Icons.search,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if(states is OnLoadingSearchData)
                  LinearProgressIndicator(),
                cubit.searchData!=null?
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      itemBuilder:(context,index)=>productItem(cubit.searchData!.model!.data[index], context,),
                      separatorBuilder:(context,index)=>myDevider(),
                      itemCount: cubit.searchData!.model!.data.length),
                ):Container(),
              ],
            ),
          ),
        );
      },
    );
  }
   // Widget productItem(SearchProducts? model,BuildContext context)=>Container(
   //   color: Colors.white,
   //   child: Column(
   //     crossAxisAlignment: CrossAxisAlignment.start,
   //     children: [
   //       Stack(
   //         alignment: AlignmentDirectional.bottomStart,
   //         children: [
   //           Image(image: NetworkImage(model!.image!),
   //             height: 200,
   //             width: double.infinity,
   //             fit: BoxFit.cover,
   //           ),
   //           if(model.discount!=0)
   //             Padding(
   //               padding: EdgeInsets.symmetric(horizontal: 5.0),
   //               child: Text("Discount",
   //                 textAlign: TextAlign.end,
   //                 style: TextStyle(
   //                   backgroundColor: Colors.red,
   //                   color: Colors.white,
   //                 ),
   //               ),
   //             ),
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
   //                       "${model.oldPrice!}",
   //                       style: TextStyle(
   //                         fontSize: 12,
   //                         color: Colors.grey,
   //                         decoration: TextDecoration.lineThrough,
   //                       ),
   //                     ),
   //                   Spacer(),
   //                   IconButton(onPressed: (){
   //                     ShopAppCubit.get(context).changeFavorites(model.id);
   //                   }, icon: CircleAvatar(
   //                     backgroundColor:ShopAppCubit.get(context).favorities![model.id]==true? Colors.blueAccent:Colors.grey,
   //                     child: Icon(Icons.favorite_border,
   //                       color: Colors.white,
   //                     ),),)
   //                 ]
   //             ),
   //           ],
   //         ),
   //       ),
   //     ],
   //   ),
   // );
}
