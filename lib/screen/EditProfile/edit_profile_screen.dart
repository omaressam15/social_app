import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../HomeLayout/cubit/home_cubit.dart';
import '../HomeLayout/cubit/home_state.dart';

class EditProfile extends StatelessWidget {
   EditProfile({Key key}) : super(key: key);

  final nameController = TextEditingController();
  final bioController  = TextEditingController();
  final phoneController  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitHome,StatesHome> (

        listener: (state,context){},
        builder: (context,state){

      var userModel = CubitHome.get(context).userDataModel;
      var profileImage = CubitHome.get(context).profileImage;
      var coverImage = CubitHome.get(context).coverImage;



      nameController.text = userModel.name;
      bioController.text = userModel.bio;
      phoneController.text = userModel.phone;

      return  Scaffold(
        appBar: appBar(title: 'Edit Profile', context: context,
            action: [
              TextButton(
                  onPressed: () {
                    CubitHome.get(context).updateUserData(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                    );

                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                width: 12,
              ),
            ]),
            body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(state is LoadingUpdateUserData)
                const LinearProgressIndicator(),
                SizedBox(
                  height: 230,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 165,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: coverImage ==null? NetworkImage(userModel.cover):FileImage(coverImage)
                                  )
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                CubitHome.get(context).getCoverImage();
                              },
                              icon: const CircleAvatar(
                                child: Icon(IconBroken.Camera,size: 18,),
                              ),

                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child:  CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null ? NetworkImage(userModel.image) :FileImage(profileImage),

                            ),
                          ),
                  IconButton(
                    onPressed: (){
                      CubitHome.get(context).getProfileImage();
                    },
                    icon: const CircleAvatar(
                      child: Icon(IconBroken.Camera,size: 16,),
                    ),

                  )
                        ],
                      ),

                    ],
                  ),
                ),
                if(profileImage !=null ||coverImage!=null)
                const SizedBox(height: 20,),
                if(profileImage !=null ||coverImage!=null)
                Row(
                  children:  [
                    if(coverImage !=null)
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,


                          children: [
                            OutlinedButton(
                       onPressed: () {
                         CubitHome.get(context).uploadCoverPic(
                             name: nameController.text,
                             bio: bioController.text
                             , phone: phoneController.text);
                       },

                       child: const Text('Update Cover Image'),
                              style: OutlinedButton.styleFrom(
                                maximumSize: MediaQuery.of(context).size
                              ),

                    ),
                            const SizedBox(height: 1,),
                            if(state is LoadingUpdateCoverImage)
                            const LinearProgressIndicator(),
                          ],
                        )),

                    if(profileImage !=null && coverImage!=null)
                      const SizedBox(width: 12,),

                    if(profileImage!=null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            OutlinedButton(
                       onPressed: () {
                         CubitHome.get(context).uploadProfilePic(
                             name: nameController.text,
                             bio: bioController.text
                             , phone: phoneController.text);
                       },
                              style: OutlinedButton.styleFrom(
                                  maximumSize: MediaQuery.of(context).size
                              ),
                       child: const Text('Update Profile Image'),
                    ),
                            const SizedBox(height: 1,),
                            if(state is LoadingUpdateProfileImage)
                            const LinearProgressIndicator(
                            ),
                          ],
                        )),

                  ],
                ),

                const SizedBox(height: 30,),

                defaultFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return 'name must not be empty';
                    }
                  },
                  controller: nameController,
                  label: 'enter your name',
                  iconData: IconBroken.User,


                ),
                const SizedBox(height: 10,),
                defaultFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Bio must not be empty';
                    }
                  },
                  controller: bioController,
                  label: 'enter your bio',
                    iconData: IconBroken.Activity,



                ),

                const SizedBox(height: 10,),
                defaultFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return 'phone must not be empty';
                    }
                  },
                  controller: phoneController,
                  label: 'enter your phone',
                  iconData: IconBroken.Call,



                ),





              ],
            ),
          ),
        ),
      );


    }
    );


  }
}


