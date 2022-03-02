import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import 'package:social_app/HomeLayout/widget/intro_card.dart';
import 'package:social_app/HomeLayout/widget/post_card.dart';

class FeedScreen extends StatelessWidget {
   const FeedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitHome,StatesHome>(
        listener: (context,stats){},
        builder: (context,stats){

         var postModel =  CubitHome.get(context);

          return  ConditionalBuilder(
            condition:postModel.postData.isNotEmpty && postModel.userData!=null,
            builder: (context)=>SingleChildScrollView(
              primary: true,

              child: Column(

                children:  [

                  const IntroCard(),

                  const SizedBox(height: 12,),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=> PostCard(postData: postModel.postData[index],index: index,),

                      itemCount: CubitHome.get(context).postData.length
                  ),

                ],
              ),
            ),
            fallback:(context)=> const Center(child: CircularProgressIndicator(),),
          );
        });
  }
}
