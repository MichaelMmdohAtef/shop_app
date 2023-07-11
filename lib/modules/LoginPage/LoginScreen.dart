import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shopApp_Layout/shop_layout.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:toast/toast.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passWordController = TextEditingController();

  bool isPassword = true;

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async{
          if (state is SocialLoginErrorState) {

            // toast(message: state.error, status: toastStatus.ERROR,);
          }
          if (state is SocialLoginSuccessState) {

            if(state.loginData?.status??false){
              String? token=state.loginData!.data!.token;
             await CasheHelper.setString(key: TOKEN, value:token);
              var token1=await CasheHelper.getData(key: TOKEN);
              print(token1);
              toast(message: state.loginData!.message!, status: toastStatus.SUCCESS,);
              navigateAndFinish(context,ShopAppScreen());
            }else{
              toast(message: state.loginData!.message!, status: toastStatus.ERROR,);

            }
            // navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Shop App",
                style: TextStyle(
                  fontFamily: 'shortBaby',
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.deepOrange,
                ),
              ),
              backgroundColor: backGroundColor,
              elevation: 0,
              centerTitle: true,
            ),
            body: Container(
              color: backGroundColor,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black,
                                    fontFamily: 'shortBaby',
                                  ),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                    fontFamily: 'shortBaby',
                                    fontSize: 20,
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: "Email Address",
                          hint: "please enter your email",
                          onValidate: (value) {
                            if (value!.split("@")[0].isEmpty || value.isEmpty) {
                              return "Email Address can not be embty";
                            }
                            if (value.contains("@gmail.com")) {
                              return null;
                            } else {
                              return "Email Address is bad format";
                            }
                          },
                          prefixIcon: Icons.email,
                          typeKeyboard: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passWordController,
                          label: "Password",
                          ispass: cubit.isPassword,
                          onSuffixPressed: () {
                            cubit.onChangePassword();
                          },
                          suffixIcon: cubit.isPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return "password can not be embty";
                            } else if (value.length <= 5) {
                              return "password should be at least 9 characters";
                            }
                          },
                          hint: "please enter your password",
                          prefixIcon: Icons.lock,
                          typeKeyboard: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        state is SocialLoginLoadingState
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : defaultButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await cubit.LoginAccount(
                                      emailController: emailController,
                                      passWordController: passWordController,
                                    ).then((value){
                                      token=cubit.loginData!.data!.token;
                                      print("vv $token");
                                    });
                                    print(emailController.text);
                                    print(passWordController.text);
                                    print("object");
                                  }
                                },
                                text: "Login",
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyText1!
                                ..copyWith(
                                  color: Colors.white,
                                  // fontFamily: 'shortBaby',
                                ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                                'Register Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.amber,
                                      // fontFamily: 'shortBaby',
                                    ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
