import 'package:flutter/material.dart';
import 'package:social_app/components.dart';
import '../../ChatDetailsScreen/chat_details_screen.dart';

class ItemUserDataBuilder  extends StatelessWidget {

 final String profileImage;

 final String name;

 final String userId;

 final String tokenDevice;

  const ItemUserDataBuilder ({Key key,this.tokenDevice,this.profileImage,this.name, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigate(ChatDetailsScreen(
            userName: name,
            userImage: profileImage,
            tokenDevice: tokenDevice,
            receiverId: userId),
            context);
      },
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                profileImage,


              ),
            ),

            const SizedBox(width: 15,),

            Text(name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),

          ],
        ),
      ),
    );
  }
}

