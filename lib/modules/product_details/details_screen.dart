
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen(this.model);
  ProductModel? model;
  var carouselController = CarouselController();
  List<Widget> images=[];


  convertStringToWidget(){
    model!.images.forEach((e) {
      images.add(
          Image(
        image: NetworkImage(e),
        fit: BoxFit.cover,
        // height: 200,
        // width: double.infinity,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    convertStringToWidget();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new),
        onPressed: (){
          Navigator.pop(context);
        }),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          top: 20,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider(
                  items: images,
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: true,
                    initialPage: 0,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 7),
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    pauseAutoPlayOnTouch: true,
                    reverse: false,
                    height: 250,
                  )),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                child: Text("Device Name",style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  height: 1.5,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),textAlign:TextAlign.start,),
              ),
              SizedBox(height: 5,),
              Text(model!.name!,style:Theme.of(context).textTheme.titleLarge!.copyWith(
                height: 1.5,
                fontSize: 22,
              )),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                child: Text("Description",style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  height: 1.5,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),textAlign:TextAlign.start,),
              ),
              SizedBox(height: 5,),
              Text(model!.description!,style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                height: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.w400
              )),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: MaterialButton(onPressed: (){}, child: Text("Add To Card"),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: MaterialButton(onPressed: (){
                          ShopAppCubit.get(context).checkIfItemInCart(model!.id!);
                          Navigator.pop(context);
                        }, child: Text("Add To Salla"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
