import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components.dart';
import '../HomeLayout/cubit/home_cubit.dart';
import '../HomeLayout/cubit/home_state.dart';
import 'widget/item_user_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {

        return  BlocConsumer<CubitHome, StatesHome>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {

            var usersList = CubitHome.get(context).userDataList;

            return ConditionalBuilder(
              condition: usersList.isNotEmpty,
              fallback:(context)=> const Center(child: CircularProgressIndicator()),
              builder: (BuildContext context) {
                return ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) => myDivider(),
                  itemBuilder: (context, index) => ItemUserDataBuilder(
                    profileImage: usersList[index].image,
                    tokenDevice: usersList[index].tokenDevice,
                    userId: usersList[index].uId,
                    name: usersList[index].name,
                  ),
                  itemCount: usersList.length,
                );
              },
            );
          },
        );
      },
    );
  }
}
