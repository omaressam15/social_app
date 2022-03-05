import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import 'package:social_app/HomeLayout/widget/comment_card.dart';
import 'package:social_app/styles/icon_broken.dart';
class CommentsSheet extends StatelessWidget {


  final int index;


   const CommentsSheet({Key key,this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var  commentForm = TextEditingController();
    return BlocConsumer<CubitHome,StatesHome>(

        listener: (context, states){},
        builder: (context,states) {

          var  cubitComments = CubitHome.get(context);
          return DraggableScrollableSheet(
            expand: false,
            builder: ( context, ScrollController scrollController) => Column(
              children: [
                Padding(
                  padding:  const EdgeInsets.all(15.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                 Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) => CommentCard(

                        commentModel:cubitComments.commentData[index] ,
                      ),
                      itemCount: cubitComments.commentData.length,



                    )),
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentForm,

                            validator: (String value){

                              if(value.isEmpty){
                                return 'please write a comment';
                              }else{
                                return null;
                              }
                            },
                            decoration:InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                prefixIcon:const Icon(IconBroken.Chat),
                                fillColor: const Color(0xfff1f2f6),
                                hintText: 'Write comment...',
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
                            cubitComments.createComments(
                                textComment: commentForm.text.toString(),
                                postId:cubitComments.postId[index]
                            );
                          },
                              icon: const Icon(Icons.send,size: 26,color: Colors.white,
                              )),
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
            maxChildSize: 0.9,
            initialChildSize: 0.9,
            minChildSize: 0.9,
          );
        }
    );
  }
}
