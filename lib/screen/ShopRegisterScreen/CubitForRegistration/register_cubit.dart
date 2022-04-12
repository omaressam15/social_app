import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/user_data_model.dart';
import 'package:social_app/constants.dart';

import 'register_stats.dart';

class SocialRegistrationCubit extends Cubit<SocialRegistrationStates>{
  SocialRegistrationCubit() : super(SocialRegistrationInitialState());

 static SocialRegistrationCubit get (context) => BlocProvider.of(context);

 FirebaseAuth auth = FirebaseAuth.instance;

 bool isPassword = true;

 IconData suffix = Icons.visibility_outlined;

 FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserData userDataModel ;


 void changePasswordVisibility(){
   isPassword = !isPassword;

   suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;

   emit(SocialChangePasswordVisibilityState());

 }

  void registrationUser ({
  @required String email,
  @required String password,
  @required String name,
  @required String phone,
}){

   emit(SocialRegistrationLoadingState());

   auth.createUserWithEmailAndPassword(
       email: email,
       password: password,

    ).then((value) {

      createUser(
          email: email,
          name: name,
          phone: phone,
          uId: value.user.uid
      );

      getUserData();

      if (kDebugMode) {
        print(value.user.email);
      }
      if (kDebugMode) {
        print(value.user.uid);
      }

    }).catchError((error){
      debugPrint(error);
      emit(SocialRegistrationErrorState(error.toString()));
    });

  }

  void createUser({
    @required String email,
    @required String name,
    @required String phone,
    @required String uId,
})
  {

    UserData userData = UserData(
      email: email,
      name: name,
      tokenDevice: tokenDevices,
      phone: phone,
      uId: uId,
      bio: 'Write your bio',
      image: 'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
      cover: 'http://iconerecife.com.br/wp-content/plugins/uix-page-builder/uixpb_templates/images/UixPageBuilderTmpl/default-cover-4.jpg'
    );

    fireStore.collection('users').doc(uId)
        .set(userData.toJson())
        .then((value) {

      emit(SocialCreateUserSuccessState(uId));

    }).catchError((onError){

      if (kDebugMode) {
        print(onError.toString());
      }
      emit(SocialCreateUserErrorState(onError.toString()));
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