import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import 'package:social_app/HomeLayout/home_layout.dart';
import 'package:social_app/LoginScreen/login_screen.dart';
import 'BlocObserver/bloc_observer.dart';
import 'CacheHelper.dart/cache_helper.dart';
import 'constants.dart';
import 'styles/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();


  Widget widgets;

  uId = CacheHelper.getData(key:'uId');

  if (kDebugMode) {
    print('My Id is $uId');
  }

  if(uId!=null){
    widgets = const HomeLayout();
  }else{
    widgets = const LoginScreen();
  }

  runApp( MyApp(startWidget: widgets));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.startWidget}) : super(key: key);
    final Widget startWidget;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context)=> CubitHome()..getUserData()..getPostsData()..getListOfUsers(),

      child: BlocConsumer <CubitHome,StatesHome>(

        listener: (context ,states){},
        builder: (context,states){
          return  MaterialApp(
            title: 'Flutter Demo',
            theme:lightTheme,
            home: startWidget,
          );
        },

      ),

    );
  }
}