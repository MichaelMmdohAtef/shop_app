import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:toast/toast.dart';
import '../../layouts/shopApp_Layout/shop_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();

  bool isPassword=true;

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){

           if(state is SocialRegisterSuccessState){

            if(state.registerModel!.status==true){
              Toast.show(state.registerModel!.message!,
                gravity: Toast.bottom, duration: 3,
              );
              navigateAndFinish(context,ShopAppScreen());
            }else{
              Toast.show(state.registerModel!.message!,
                gravity: Toast.bottom, duration: 3,
              );
            }
          }
          else if(state is SocialRegisterErrorState){
            Toast.show(state.error,
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
            );
          }

        },
        builder:(context,states){
          var cubit=RegisterCubit.get(context);
          print(cubit.isPassword);
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
              backgroundColor: Colors.indigo,
              elevation: 0,
              centerTitle: true,
            ),
            body:Container(
              color: backGroundColor,
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context).textTheme.headline3!
                                .copyWith(
                              color: Colors.black,
                              fontFamily: 'shortBaby',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: nameController,
                            label: "Name",
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "name can not be embty";
                              }
                            },
                            hint: "enter your Name",
                            typeKeyboard: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: emailController,
                            label: "Email Address",
                            hint: "please enter your email",
                            onValidate: (value) {
                              print(value!.split("@")[0]);
                              if(value!.split("@")[0].isEmpty  || value.isEmpty) {
                                return "Email Address can not be embty";
                              }
                              if(value.contains("@gmail.com")){
                                return null;
                              }
                              else{
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
                            controller: phoneController,
                            label: "Phone Number",
                            hint: "please enter your Number",
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "this Field can not be embty";
                              }
                              else if(value.length<10 &&value.length>10){
                                return "Number should be at least 11 characters";
                              }
                            },
                            prefixIcon: Icons.phone,
                            typeKeyboard: TextInputType.number,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passWordController,
                            label: "Password",
                            ispass: cubit.isPassword,
                            onSuffixPressed: (){
                              cubit.onChangePassword();
                            },
                            suffixIcon: cubit.isPassword?Icons.visibility_off:Icons.visibility,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "password can not be embty";
                              }
                              else if(value.length<=8){
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
                          defaultFormField(
                            controller: confirmPassWordController,
                            label: "confirm Password",
                            ispass: cubit.isPassword,
                            onSuffixPressed: (){
                              cubit.onChangePassword();
                            },
                            suffixIcon: cubit.isPassword?Icons.visibility_off:Icons.visibility,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "password can not be embty";
                              }
                              else if(value.length<=8){
                                return "password should be at least 9 characters";
                              }
                            },
                            hint: "enter your password again",
                            prefixIcon: Icons.lock,
                            typeKeyboard: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          defaultButton(onPressed: () async{
                            // print(formKey.currentState!.validate().toString());
                            print(emailController.text);
                            if(formKey.currentState!.validate()){
                              if(passWordController.text!=confirmPassWordController.text){
                                Toast.show("password should be equal to confirm password");
                              }
                              else {
                                cubit.registerAccount(
                                  nameController: nameController,
                                  emailController: emailController,
                                  phoneController: phoneController,
                                  passWordController: passWordController,
                                  confirmPassWordController: confirmPassWordController,
                                );

                              }
                            }
                            // return null;
                          },
                            text: 'Register',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) ,
          );
        } ,
      ),
    ) ;


  }
}
