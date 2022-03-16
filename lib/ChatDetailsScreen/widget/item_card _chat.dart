import 'package:flutter/material.dart';
import 'package:social_app/Models/chatting.dart';

Widget itemCardChatLeft(ChatData chatData){
  return Align(
    alignment: Alignment.topLeft,
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
          Text(
            chatData.message,

          ),
          Text(
            chatData.dateTime,

          ),
        ],
      ),
    ),
  );
}

Widget itemCardChatRight(ChatData chatData){
  return  Align(
    alignment: Alignment.topRight,
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
          Text(
            chatData.message,

          ),
          Text(
            chatData.dateTime,

          ),
        ],
      ),
    ),
  );
}