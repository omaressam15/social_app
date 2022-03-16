import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/HomeLayout/cubit/home_cubit.dart';
import 'package:social_app/HomeLayout/cubit/home_state.dart';
import 'package:social_app/styles/icon_broken.dart';

class AddNewPost extends StatelessWidget {
   AddNewPost({Key key}) : super(key: key);

  final textPostController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitHome,StatesHome>(

        listener: (context,state){

        },

        builder: (context,state) {

          var userData = CubitHome.get(context).userDataModel;
          var postImage = CubitHome.get(context).postImage;
          var lunchPost = CubitHome.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
              actions: [
                TextButton(onPressed: (){
                  var now = DateTime.now();
                  if(postImage == null){
                    lunchPost.createPostOnly(
                        textPost: textPostController.text,
                        datetime: now.toString()
                    );
                  }else{
                    lunchPost.createPostWithPhoto(
                        textPost: textPostController.text,
                        dateTime: now.toString());
                  }
                }, child: const Text('POST',style: TextStyle(fontWeight: FontWeight.bold),)),
                const SizedBox(width: 20,)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if(state is LoadingCreatePost)
                    const LinearProgressIndicator(),
                  Row(
                    children:  [
                      CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                          userData.image

                        ),
                      ),

                      const SizedBox(width: 15,),

                      Text(userData.name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                    ],
                  ),
                  const SizedBox(height: 35,),
                  Expanded(

                    child: TextFormField(
                      controller: textPostController,
                      decoration: const InputDecoration.collapsed(
                          border: InputBorder.none,

                          hintText: 'What is in your mind...',hintStyle: TextStyle(fontSize: 25,color: Colors.grey)),
                      style: const TextStyle(fontSize: 25,color: Colors.black),

                    ),

                  ),
                  if(postImage !=null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(postImage)
                            )
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          CubitHome.get(context).removeImagePost();
                        },
                        icon:const Icon(Icons.cancel,color: Colors.white,)

                      )
                    ],
                  ),


                  Row(
                    children: [

                      Expanded(
                        child: TextButton(
                            onPressed: (){
                              CubitHome.get(context).pickerPostImage();
                            },
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('add photo'),
                                SizedBox(width: 5,),
                                Icon(IconBroken.Image),
                              ],
                            )),
                      ),

                      Expanded(
                        child: TextButton(
                            onPressed: () {  },
                            child: const Text('# Tags')),
                      ),

                    ],
                  ),

                ],

              ),
            ),
          );
        },
    );
  }
}
