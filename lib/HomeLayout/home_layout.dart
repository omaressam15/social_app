import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/AddNewPostSceen/add_new_post_screen.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import 'package:social_app/components.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../CacheHelper.dart/cache_helper.dart';
import '../LoginScreen/Cubit/stats_login.dart';
import '../constants.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitHome,StatesHome>(

        listener: (BuildContext context,states){

          if(states is ScreenNewPost){

            navigate( AddNewPost(), context);

          }
        },

        builder: (context,states){

          var cubit = CubitHome.get(context);

          return Scaffold(

            appBar: AppBar(
              title:  Text(cubit.titles[cubit.currentIndex],style:Theme.of(context).textTheme.headline6,),
              actions: [
                IconButton(onPressed:(){}, icon: const Icon(IconBroken.Notification)),
                IconButton(onPressed:(){}, icon: const Icon(IconBroken.Chat)),
              ],
            ),

            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)=> cubit.changeButtonNavigationBar(index),
              items:  const [
                BottomNavigationBarItem(
                  label: 'Home',
                    icon: Icon(IconBroken.Home)),

                BottomNavigationBarItem(
                  label: 'Chat',
                    icon: Icon(IconBroken.Chat)),

                BottomNavigationBarItem(
                    label: 'Post',
                    icon: Icon(IconBroken.Bag_2)),


                BottomNavigationBarItem(
                  label: 'Users',
                    icon: Icon(IconBroken.User)),

                BottomNavigationBarItem(
                  label: 'Setting',
                    icon: Icon(IconBroken.Setting)),
              ],
            ),
          );
        }
    );
  }
}