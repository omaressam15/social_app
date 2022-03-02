import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/user_data_model.dart';
import 'package:social_app/ShopRegisterScreen/CubitForRegistration/register_stats.dart';

class SocialRegistrationCubit extends Cubit<SocialRegistrationStates>{
  SocialRegistrationCubit() : super(SocialRegistrationInitialState());

 static SocialRegistrationCubit get (context) => BlocProvider.of(context);

 FirebaseAuth auth = FirebaseAuth.instance;

 bool isPassword = true;

 IconData suffix = Icons.visibility_outlined;

 FirebaseFirestore fireStore = FirebaseFirestore.instance;


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
      phone: phone,
      uId: uId,
      bio: 'hi i am omar',
      image: 'https://image.freepik.com/free-photo/beauty-fashion-concept-carefree-beautiful-girl-with-curly-hair-naked-shoulders-smiling_176420-20176.jpg',
      cover: 'https://image.freepik.com/free-photo/beauty-fashion-concept-carefree-beautiful-girl-with-curly-hair-naked-shoulders-smiling_176420-20176.jpg'
    );

    fireStore.collection('users').doc(uId)
        .set(userData.toJson())
        .then((value) {

      emit(SocialCreateUserSuccessState());

    }).catchError((onError){

      if (kDebugMode) {
        print(onError.toString());
      }
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

}