import 'package:flutter/material.dart';

class ItemUserDataBuilder  extends StatelessWidget {

 final String profileImage;

 final String name;


  const ItemUserDataBuilder ({Key key,this.profileImage,this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

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

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [

                  Row(
                    children:  [
                      Text(name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                      const SizedBox(width: 5,),
                      const Icon(Icons.check_circle,color: Colors.blue,size: 17,)
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

