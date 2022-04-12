import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BlocObserver/bloc_observer.dart';
import 'CacheHelper.dart/cache_helper.dart';
import 'components.dart';
import 'constants.dart';
import 'dioHelper/dio_network.dart';
import 'notification/firebaseMessagingBackground.dart';
import 'screen/HomeLayout/cubit/home_cubit.dart';
import 'screen/HomeLayout/cubit/home_state.dart';
import 'screen/HomeLayout/home_layout.dart';
import 'screen/LoginScreen/login_screen.dart';
import 'styles/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  DioHelper.inti();
  tokenDevices = await FirebaseMessaging.instance.getToken();

  if (kDebugMode) {
    print('token Device is $tokenDevices');
  }


  // foreground fcm
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS,);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  uId = CacheHelper.getData(key:'uId');
  Widget widgets;



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

      create: (context)=> CubitHome()..getPostsData(),

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