import 'package:flutter/material.dart';
import 'package:social_app/Models/comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;


class CommentCard extends StatelessWidget {

  final CommentModel commentModel;

  const CommentCard({Key key,this.commentModel}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    print(timeago.acmoConvertToUrduNumbers(55));


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

           CircleAvatar(
            radius: 20,

            backgroundImage: NetworkImage(commentModel.image),
          ),
          const SizedBox(width: 10,),
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(commentModel.userName,
                    style: const TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  Text(commentModel.textComment,
                    overflow: TextOverflow.visible,style: const TextStyle(
                      color: Colors.black,
                  ),),
                  /*Text(timeago.format(time),
                    overflow: TextOverflow.visible,style: const TextStyle(
                      color: Colors.black,
                  ),),*/

                ],
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xfff1f2f6),
              borderRadius: BorderRadius.all(Radius.circular(15))

            ),
          )
        ],
      ),
    );
  }
}
