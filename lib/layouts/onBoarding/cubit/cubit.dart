import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/onBoarding/cubit/states.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import '../../../models/OnBoardingModel.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>{

  OnBoardingCubit():super(OnInitializedBoardingStates());

  static OnBoardingCubit get(context)=>BlocProvider.of(context);

  bool isLastPage=false;

  List<OnBoardingModel> listModel=[
    OnBoardingModel(image:'assets/images/welcome.png',
      title: "",
      body: 'Welcome, to our shopping App, i wish to enjoy with Shop App',),
    OnBoardingModel(image:'assets/images/shop app.png',
        title: "",
        body: "with our Shop App you will find everything that you need"),
    OnBoardingModel(image:'assets/images/start shopping.png',
        title: "",
        body: "please continue to start with Shopping"),
  ];

  onOpenedLastIndex(int index){
    if (index==listModel!.length-1){
      isLastPage = true;
    }
    else{
      isLastPage=false;
    }
    print(index);
    emit(OnFinishedBoardingStates());
  }

  // onChangeLastIndex({bool? isSkipped}){
  //   if(isSkipped!=null){
  //     CasheHelper.setBoolean(key: isLast, value: isSkipped).then((value){
  //       emit(OnNavigateBoardingStates());
  //     });
  //   }else{
  //     CasheHelper.setBoolean(key: isLast, value: isLastPage).then((value){
  //       print(isLastPage);
  //       emit(OnNavigateBoardingStates());
  //     });
  //   }
  // }

}