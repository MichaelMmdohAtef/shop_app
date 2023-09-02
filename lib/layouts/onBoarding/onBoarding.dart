import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/layouts/onBoarding/cubit/cubit.dart';
import 'package:shop_app/layouts/onBoarding/cubit/states.dart';
import 'package:shop_app/layouts/shopApp_Layout/shop_layout.dart';
import 'package:shop_app/modules/LoginPage/LoginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/OnBoardingModel.dart';


class OnBoardingScreen extends StatelessWidget {
  var boardingController=PageController();
  BuildContext? glopalContext;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>OnBoardingCubit(),
    child: BlocConsumer<OnBoardingCubit,OnBoardingStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var cubit=OnBoardingCubit.get(context);
        glopalContext=context;
        return Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
            centerTitle:true ,
            title: Text("Shop App",
              style: TextStyle(
                fontFamily: 'short',
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: Colors.deepOrange,
              ),
            ),
            actions:
            [
              TextButton(onPressed: () {
                navigateOnBording();
              },
                  child: Text("Skip",
                    style: TextStyle(color: Colors.white),
                  ))],
          ),
          body: PageView.builder(
            controller: boardingController,
            itemBuilder: (context, index) => pageViewer(cubit.listModel![index],cubit,context),
            itemCount: cubit.listModel!.length,
            onPageChanged: (index) {
              cubit.onOpenedLastIndex(index);
            },
          ),
        );
      } ,
    ),
    );

  }


  Widget pageViewer(OnBoardingModel model1,cubit,glopalContext) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 240,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(60),
                ),
                child: Image(image: AssetImage('${model1!.image}'),
                fit: BoxFit.fill,
                ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              child: Text(
                '${model1!.body}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24,
                    fontFamily: "shortBaby",
                color: Colors.white
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller:boardingController,
                      count: cubit.listModel!.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight:10 ,
                        dotWidth: 7,
                        expansionFactor: 4,
                        spacing: 8,
                        activeDotColor: Colors.deepOrange,
                      ),
                    ),
                  ),
                    ),
                FloatingActionButton(
                    child: Icon(Icons.arrow_forward),
                    onPressed:() async{
                      if (cubit.isLastPage) {
                        navigateOnBording();
                      }
                      else {
                        boardingController.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                  backgroundColor: Colors.deepOrange,
                    ),
              ],
            ),
          ],
        ),
      );
  
  void navigateOnBording() async{
    await CasheHelper.setBoolean(key: ONBORDING, value: true);
    print(CasheHelper.getData(key: ONBORDING));
   return navigateAndFinish(glopalContext,LoginScreen());
  }
}
