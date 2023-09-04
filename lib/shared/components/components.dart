import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/OnBoardingModel.dart';
import 'package:shop_app/modules/product_details/details_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:toast/toast.dart';

import '../../layouts/shopApp_Layout/cubit/cubit.dart';
import '../../models/search_model.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required String label,
        required String hint,
        required String? Function(String?) onValidate,
        IconData? prefixIcon,
        IconData? suffixIcon,
        TextInputType? typeKeyboard,
        bool ispass = false,
        bool isprofile = false,
        Function()? onSuffixPressed,
        Function(String)? onFieldSubmitted}) =>
    TextFormField(
      controller: controller,
      obscureText: ispass!,
      cursorColor: defaultColor,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: '${label}',
        hintText: "${hint}",
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: defaultColor,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: TextStyle(
          color: defaultColor,
          fontSize: 20,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabled: isprofile ? false : true,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
      ),
      keyboardType: typeKeyboard,
      validator: onValidate,
    );

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 45,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: MaterialButton(
          color: defaultColor,
          textColor: CupertinoColors.darkBackgroundGray,
          onPressed: onPressed,
          child: Text(
            "${text}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

void navigateTo(context, route) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );

void navigateAndFinish(context, route) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => route), (route) => false);

void toast({
  required String message,
  required toastStatus status,
}) =>
    Toast.show(
      message,
      gravity: Toast.bottom,
      duration: 3,
      backgroundColor: changetoastColor(status),
    );

enum toastStatus { SUCCESS, ERROR }

Color changetoastColor(status) {
  Color? color;
  switch (status) {
    case toastStatus.SUCCESS:
      color = Colors.green;
      break;
    case toastStatus.ERROR:
      color = Colors.red;
      break;
  }
  return color!;
}

Widget myDevider() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.black,
        child: SizedBox(
          width: double.infinity,
          height: 2,
        ),
      ),
    );

Widget productItem(var model, BuildContext context,
        {bool isFavourite = false}) =>
    InkWell(
      onTap: (){
        navigateTo(context,ProductDetailsScreen(model));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.image!),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                if (isFavourite)
                  if (model.discount != 0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "Discount",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          backgroundColor: Colors.red,
                          color: Colors.white,
                        ),
                      ),
                    ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Row(children: [
                    Text(
                      "${model.price!}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (isFavourite)
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice!}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopAppCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            ShopAppCubit.get(context).favourites![model.id] ==
                                    true
                                ? Colors.blueAccent
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
