import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings/cubit/cubit.dart';
import 'package:shop_app/modules/settings/cubit/states.dart';
import 'package:toast/toast.dart';

import '../../layouts/shopApp_Layout/cubit/cubit.dart';
import '../../layouts/shopApp_Layout/cubit/states.dart';
import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>SettingCubit()..getProfileData(),
      child: BlocConsumer<SettingCubit,SettingStates>(
      listener:(context,state){
        if (state is SocialSuccessUpdatedProfileState){
          if(state.profileModel!.status==true){
            Toast.show(state.profileModel!.message!,
              gravity: Toast.bottom, duration: 3,
            );
          }else{
            Toast.show(state.profileModel!.message!,
              gravity: Toast.bottom, duration: 3,
            );
          }
        }
      } ,
      builder:(context,states){
        var cubit=SettingCubit.get(context);
        ToastContext().init(context);
        if(cubit.profileModel!= null){
            if (cubit.profileModel!.status == true) {
              nameController.text = cubit.profileModel!.data!.name!;
              emailController.text = cubit.profileModel!.data!.email!;
              phoneController.text = cubit.profileModel!.data!.phone!;
            }
          }
          return Scaffold(
          body: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Profile',
                        style: Theme.of(context).textTheme.headline3!
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
                        isprofile: true,
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
                      defaultButton(onPressed: () {
                        if(formKey.currentState!.validate()){
                          cubit.updateProfileData(
                              nameController: nameController,
                              phoneController: phoneController).then((value){
                            nameController.text = cubit.profileModel!.data!.name!;
                            emailController.text = cubit.profileModel!.data!.email!;
                            phoneController.text = cubit.profileModel!.data!.phone!;
                          });
                              }
                        // return null;
                      },
                        text: 'Update',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ) ,
        );
      },
    ),);

  }
}
