import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/LoginScreen/Cubit/stats_login.dart';

import '../../CacheHelper.dart/cache_helper.dart';
import '../../HomeLayout/cubit/home_state.dart';
import '../../Models/user_data_model.dart';
import '../../constants.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginInitialState());


 static SocialLoginCubit get(context)=> BlocProvider.of(context);

 bool isPassword = true;


 IconData suffix = Icons.visibility_outlined;

 void changePasswordVisibility(){
   isPassword = !isPassword;

  suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;

   emit(ChangeVisibility());

 }

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserData userDataModel ;



  void loginUser ({
  @required String email,
  @required String password,
}){

   emit(SocialLoginLoadingState());

   auth.signInWithEmailAndPassword(
       email: email,
       password: password

    ).then((value) {

      print(value.user.email);
      print(value.user.uid);
      emit(SocialLoginSuccessState(value.user.uid));
      getUserData();
    }).catchError((error){
      print(error);
      emit(SocialLoginErrorState(error.toString()));
    });

  }

  void getUserData (){

    emit(LoadingUsersData());

    firestore.collection('users').doc(uId).get()
        .then((value) {

      userDataModel = UserData.fromJson(value.data());

      emit(GetUsersData());
    })
        .catchError((onError){
      emit(GetUsersDataError());
      if (kDebugMode) {
        print(onError);
      }
    });

  }

}