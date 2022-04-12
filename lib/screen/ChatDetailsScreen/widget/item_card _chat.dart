import 'package:flutter/material.dart';
import 'package:social_app/Models/chatting.dart';

import '../../reviewPhoto.dart';

Widget itemCardChatLeft(ChatData chatData,context,index){
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(10),
              bottomLeft:Radius.circular(10),
              bottomRight: Radius.circular(10),

            )

        ),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(chatData.imageChatting!= '')
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return  ReviewPhoto(photo: chatData.imageChatting,index: index,);
                  }));
                },
                child: Hero(
                  tag: index.toString(),
                  child: Container(
                    height: 250,
                    width:260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            chatData.imageChatting
                          ),
                        )
                    ),
                  ),
                ),
              ),
            Text(
              chatData.message,

            ),
            Text(
              chatData.time,

            ),
          ],
        ),
      ),
    ),
  );
}

Widget itemCardChatRight(ChatData chatData,context,index){
  return  Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: const BoxDecoration(
            color: Color(0xffe7ffdb),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),

            )

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            if(chatData.imageChatting!= '')
              InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  ReviewPhoto(photo: chatData.imageChatting,index: index,);
                }));
              },
              child: Hero(
                tag: index.toString(),
                child: Container(
                  height: 250,
                  width:260,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            chatData.imageChatting
                        ),
                      )
                  ),
                ),
              ),
            ),
            Text(
              chatData.message,

            ),
            Text(
              chatData.time,

            ),
          ],
        ),
      ),
    ),
  );
}