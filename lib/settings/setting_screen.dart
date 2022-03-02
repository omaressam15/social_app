import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/EditProfile/edit_profile_screen.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome,StatesHome>(
      listener:(state,context){} ,
      builder:(context,stata){

        var userModel = CubitHome.get(context).userData;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              SizedBox(
                height: 230,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration:  BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userModel.cover)
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(userModel.image),

                      ),
                    ),

                  ],
                ),
              ),
              Text(userModel.name,style: Theme.of(context).textTheme.bodyText1,),
              Text(userModel.bio,style: Theme.of(context).textTheme.caption,),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:(){} ,
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('post',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){} ,
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('post',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){} ,
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('post',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){} ,
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('post',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: (){}, child: Text('Edit your photo',
                        style:Theme.of(context).textTheme.subtitle1 ,)),
                    ),
                    const SizedBox(width: 10,),
                    OutlinedButton(onPressed: ()=> navigate( EditProfile(), context), child: const Icon(IconBroken.Edit),),

                  ],
                ),
              )
            ],
          ),
        );
      } ,
    );
  }
}
