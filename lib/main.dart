import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/onBoarding/onBoarding.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shopApp_Layout/cubit/states.dart';
import 'package:shop_app/layouts/shopApp_Layout/shop_layout.dart';
import 'package:shop_app/modules/LoginPage/LoginScreen.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterScreen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new PostHttpOverrides();
  await CasheHelper.init();
  await DioHelper.init();

  token= await CasheHelper.getData(key: TOKEN);
  print(token);
  token!=null?token=token.toString():token=null;
  bool? onBording = await CasheHelper.getData(key:ONBORDING);
  onBording!=null?onBording=onBording:onBording=false;

  Widget screens() {
    Widget widget;
    onBording!
        ? token != null
            ? widget=ShopAppScreen()
            : widget=LoginScreen()
        : widget=OnBoardingScreen();
    return widget;
  }

  runApp(MyApp(screens()));
}

class MyApp extends StatelessWidget {
  Widget? widget;
   MyApp(this.widget);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,SystemUiOverlay.top
    ]);
    return BlocProvider(create:(context)=>
    token==null?ShopAppCubit():
    ShopAppCubit()..getDataModel()
        ..getCategories()
        ..getFavourites()
      ..getCarts()
      ..updateCarts()
      ,
    child: BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener:(context,states){} ,
      builder:(context,states){
      var cubit=ShopAppCubit.get(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            // bottomAppBarColor: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor:Colors.white ,
              elevation: 0,
                titleTextStyle: TextStyle(
                color:Colors.indigo,
                fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
            ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.indigo,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              selectedLabelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              showUnselectedLabels: true,
              elevation: 0,

            ),
            primarySwatch: Colors.blue,
          ),
          home:widget,
        );
      } ,
    ),
    );


  }
}
