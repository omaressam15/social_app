import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/post_data_model.dart';
import 'package:social_app/styles/icon_broken.dart';
import '../../HomeLayout/cubit/home_cubit.dart';
import '../../HomeLayout/cubit/home_state.dart';
import '../../reviewPhoto.dart';
import 'commets_sheet.dart';

class PostCard extends StatelessWidget {

 final PostData postData;

 final int index;

 const PostCard({Key key,this.postData,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitHome,StatesHome>(
        listener: (context,states){},
        builder: (context,states){
          return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 15,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            postData.profileImage,


                          ),
                        ),

                        const SizedBox(width: 15,),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [

                              Row(
                                children:  [
                                  Text(postData.name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                  const SizedBox(width: 5,),
                                  const Icon(Icons.check_circle,color: Colors.blue,size: 17,)
                                ],
                              ),
                              Text(postData.dateTime,style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.normal,fontSize: 14,height: 1),),

                            ],
                          ),
                        ),

                        IconButton(onPressed: (){}, icon: const Icon(IconBroken.More_Circle))

                      ],
                    ),

                    const SizedBox(height: 10,),

                    Divider(
                      height: 10,
                      color: Colors.grey[300],
                    ),

                    const SizedBox(height: 10,),

                    Text(postData.textPost
                        ,style: Theme.of(context).textTheme.subtitle1.copyWith(height: 1.5)),

                    /*SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 8,

                      children: [

                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software_Devlopment',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: (){},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              )
                              , child: const Text('#Software',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                          height: 25,
                        ),

                      ],
                    ),
                  ),*/

                    const SizedBox(
                      height: 10,
                    ),
                    if(postData.postImage!= '')
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return  ReviewPhoto(photo: postData.postImage,index: index,);
                          }));
                        },
                        child: Hero(
                          tag: index.toString(),
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      postData.postImage,

                                    )
                                )
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 8,),

                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children:   [

                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (kDebugMode) {
                                    print('like');
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(

                                    children: [
                                        const Icon(

                                        //CubitHome.get(context).isLikes[CubitHome.get(context).userDataModel.uId]?

                                        IconBroken.Heart,//: IconBroken.Activity?? IconBroken.Activity,

                                    // color:CubitHome.get(context).isLikes[CubitHome.get(context).userDataModel.uId]?

                                            color: Colors.red,//: Colors.black??Colors.black

                                      ),
                                      const SizedBox(width: 10,),
                                      Text(
                                        '${CubitHome.get(context).likesNumber[CubitHome.get(context).postId[index]]}',
                                        style: TextStyle(
                                            color: Colors.grey[600]
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )),

                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (kDebugMode) {
                                    print('comment');
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Text(
                                        '${CubitHome.get(context).commentsNumber[CubitHome.get(context).postId[index]]}',
                                        style: TextStyle(
                                            color: Colors.grey[600]
                                        ),
                                      ),
                                      const SizedBox(width: 3,),

                                      Text(
                                        'Comments',
                                        style: TextStyle(
                                            color: Colors.grey[600]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),

                    SizedBox(

                      width: double.infinity,
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey[400],)
                      ,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child:InkWell(
                              onTap: () {
                              CubitHome.get(context).getComments(postID: CubitHome.get(context).postId[index]);
                                showModalBottomSheet(

                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      )
                                    ),

                                    isScrollControlled: true,
                                    elevation: 5,
                                    builder: (_) => CommentsSheet(index: index,),
                                );
                               //
                                if (kDebugMode) {
                                  print('Write Comment');
                                }
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundImage: NetworkImage(
                                      CubitHome.get(context).userDataModel.image,

                                    ),
                                  ),

                                  const SizedBox(width: 15,),

                                  Text('Write a comment... ',style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.normal,fontSize: 14,height: 1),),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              CubitHome.get(context).createLike(CubitHome.get(context).postId[index]);

                              if (kDebugMode) {
                                print('Like Photo');
                              }
                            },
                            child: Row(

                              children: [
                                const Icon(
                                  IconBroken.Heart,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 10,),

                                Text(
                                  'Like',
                                  style: TextStyle(
                                      color: Colors.grey[600]
                                  ),
                                ),
                                const SizedBox(width: 5,),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
        });
  }
}

