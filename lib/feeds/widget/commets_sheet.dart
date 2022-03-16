import 'package:conditional_builder/conditional_builder.dart';
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
    return BlocConsumer<CubitHome,StatesHome>(

        listener: (context, states){},
        builder: (context,states) {
          var  commentForm = TextEditingController();

          var  cubitComments = CubitHome.get(context);
          return DraggableScrollableSheet(
            expand: false,
            builder: ( _, scrollController) {
              return Column(
              children: <Widget>[
                

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
                    child: ConditionalBuilder(
                      condition: cubitComments.commentData.isNotEmpty,
                      fallback:(context)=> Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  const [
                            Icon(Icons.comment_outlined,color: Colors.grey,size: 90,),
                            SizedBox(
                              height: 15,
                            ),
                            Text('No comment yet',style: TextStyle(color: Colors.grey,fontSize: 23,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      builder: (context) => ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),

              itemBuilder: (BuildContext context, int index) => CommentCard(

              commentModel:cubitComments.commentData[index],
              ),
              itemCount: cubitComments.commentData.length,



              ),

                    )
                ),

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
            );
            },
            maxChildSize: 0.9,
            minChildSize: 0.75,
            initialChildSize: 0.9,
          );
        }
    );
  }
}
