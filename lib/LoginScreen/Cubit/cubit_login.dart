import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/LoginScreen/Cubit/stats_login.dart';

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

    }).catchError((error){
      print(error);
      emit(SocialLoginErrorState(error.toString()));
    });

  }

}