import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import '../styles/icon_broken.dart';
import 'widget/item_card _chat.dart';
class ChatDetailsScreen  extends StatelessWidget {


  final String userImage;

  final String userName;

  final String receiverId;
  final String tokenDevice;

  const ChatDetailsScreen ({Key key,this.tokenDevice, this.userImage, this.userName, this.receiverId}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (BuildContext context) {

        CubitHome.get(context).getMessageChatting(receiverId: receiverId);

        return BlocConsumer<CubitHome,StatesHome>(

        listener: (BuildContext context, state) {  },
          builder: (BuildContext context, state) {
            var sendChatController = TextEditingController();

            var chatMassaging = CubitHome.get(context);
            return Scaffold(
              backgroundColor: const Color(0xffefe6dd),
              appBar: AppBar(
                titleSpacing: 0.0,
                title:  Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        userImage,


                      ),
                    ),

                    const SizedBox(width: 15,),

                    Text(userName,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),

                  ],
                ),
              ),

              body: Column(
                children: [

                  Expanded(
                    child: ConditionalBuilder(
                      condition: chatMassaging.listOfChats.isNotEmpty,
                      fallback:(context)=> Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Icon(Icons.chat,color: Colors.grey,size: 90,),
                          const SizedBox(
                            height: 15,
                          ),
                          Text('No Chat yet with \n$userName',style: const TextStyle(color: Colors.grey,fontSize: 23,fontWeight: FontWeight.bold),)
                        ],
                    ),
                      ),
                      builder:(context){
                       return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 14),
                          child: Column(
                            children: [
                              Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {

                                        var massages = CubitHome.get(context).listOfChats[index];

                                        if(massages.senderId == CubitHome.get(context).userDataModel.uId) {
                                          return  itemCardChatRight(massages);
                                        }
                                        return itemCardChatLeft(massages);

                                      },
                                      itemCount: chatMassaging.listOfChats.length,
                                      shrinkWrap: true,
                                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20,),

                                    ),
                                  ),

                              const SizedBox(height: 30,),

                            ],
                          ),

                        );
                      },
                    ),

                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: sendChatController,

                            validator: (String value){

                              if(value.isEmpty){
                                return 'Can\'t send message empty';
                              }else{
                                return null;
                              }
                            },
                            decoration:InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                prefixIcon:const Icon(IconBroken.Chat),
                                fillColor: const Color(0xfff1f2f6),
                                hintText: 'Write message...',
                                hintStyle: const TextStyle(color: Colors.grey),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xfff1f2f6)
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),


                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color(0xfff1f2f6)
                                  ),

                                )
                            ) ,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 23,
                          child: IconButton(onPressed: (){
                            chatMassaging.sendNotification(
                              body: sendChatController.text,
                              title: '${chatMassaging.userDataModel.name} send you massage',
                              token: tokenDevice,
                            );

                            chatMassaging.sendMessageChatting(
                                textMassage: sendChatController.text,
                                receiverID: receiverId,
                                dataTime: DateTime.now().toString()
                            );

                          },
                              icon: const Icon(IconBroken.Send,size: 26,color: Colors.white,
                              )),
                        )

                      ],
                    ),
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }
}
