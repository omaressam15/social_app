import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/AddNewPostSceen/add_new_post_screen.dart';
import 'package:social_app/Models/comment_model.dart';
import 'package:social_app/Models/post_data_model.dart';
import 'package:social_app/Models/user_data_model.dart';
import 'package:social_app/chats/chat_screen.dart';
import 'package:social_app/components.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/feeds/feed_screen.dart';
import 'package:social_app/settings/setting_screen.dart';
import 'package:social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'home_state.dart';

class CubitHome extends Cubit<StatesHome>{

  CubitHome() : super (HomeInitialState());

  static CubitHome get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  UserData userData ;


  List <Widget> screens = [

    FeedScreen(),

    const ChatScreen(),

    AddNewPost(),

    const UsersScreen(),

    const SettingScreen(),

  ];

  List <String> titles =[

    'Feed News',
    'Chat',
    'Post',
    'User',
    'Setting',
  ];

  void changeButtonNavigationBar(index){

    if(index==2){
      emit(ScreenNewPost());

    }else{
      currentIndex = index;
      emit(ChangeButtonNavigationBar());
    }
  }




  final ImagePicker pickerImage = ImagePicker();
  File profileImage;
  // Pick an image
  Future getProfileImage() async {
    final XFile image = await pickerImage.pickImage(source: ImageSource.gallery);

    if(image !=null){
      profileImage = File(image.path);
      emit(PickerProfileImageSuccess());

    }else{
      emit(PickerProfileImageError());
      if (kDebugMode) {
        print('No Image Selected');
      }

    }


  }

  File coverImage;
  // Pick an image
  Future getCoverImage() async {
    final XFile image = await pickerImage.pickImage(source: ImageSource.gallery);

    if(image !=null){
      coverImage = File(image.path);
      emit(PickerCoverImageSuccess());

    }else{
      emit(PickerCoverImageError());
      if (kDebugMode) {
        print('No Image Selected');
      }
    }
  }

  File postImage;
  // Pick an image
  Future pickerPostImage() async {
    final XFile image = await pickerImage.pickImage(source: ImageSource.gallery);

    if(image !=null){
      emit(PickerPostImageSuccess());
      postImage = File(image.path);

    }else{
      emit(PickerPostImageError());
      if (kDebugMode) {
        print('No Image Selected');
      }
    }
  }

  void removeImagePost(){
    postImage =null;
    emit(RemovePostImage());
  }


  void createPostWithPhoto({
    @required String dateTime,
    @required String textPost,

  }){

    emit(LoadingCreatePost());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('postImage/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value)=> value.ref.getDownloadURL()
        .then((value){

        createPostOnly(
          textPost: textPost,
          datetime: dateTime,
          postImage: value,
        );

        if (kDebugMode) {
          print(value);
        }

      }).catchError((onError){
      showToast(
        text: onError.toString(),
        state: ToastStates.SUCCESS,
      );
        emit(CreatePostsError());
      }))
        .catchError((error){
      showToast(
        text: error.toString(),
        state: ToastStates.ERROR,
      );
      emit(CreatePostsError());
    });

  }

  createPostOnly({
    @required String textPost,
    @required String datetime,
    String postImage,
  }){
    emit(LoadingCreatePost());
    PostData postData = PostData(
        name: userData.name,
        profileImage: userData.image,
        uId: userData.uId,
        dateTime: datetime,
        postImage: postImage?? '',
        textPost: textPost

    );


    firestore.collection('posts')
        .add(postData.toFireBase())
        .then((value) {
      showToast(
        text: 'Your post has been shared',
        state: ToastStates.SUCCESS,
      );
          emit(CreatePostsSusses());
        })
        .catchError((onError){
      showToast(
        text: onError.toString(),
        state: ToastStates.SUCCESS,
      );
      emit(UserUpdateDataError());
    });
  }



  void uploadProfilePic({
    @required String name,
    @required String bio,
    @required String phone,
}){

    emit(LoadingUpdateProfileImage());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('users profile/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage).then((value){
          value.ref.getDownloadURL().
          then((value){

           // emit(UploadProfileImageSuccess());
            updateUserData(
              name: name,
              bio: bio,
              phone: phone,
              profileImage: value,
            );
            if (kDebugMode) {
              print(value);
            }

          }).catchError((onError){
            emit(UploadProfileImageError());
          });
    })
        .catchError((error){
          emit(UploadProfileImageError());
    });

  }



  void uploadCoverPic({
    @required String name,
    @required String bio,
    @required String phone,
  }){

    emit(LoadingUpdateCoverImage());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('users cover/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage).then((value){
          value.ref.getDownloadURL().
          then((value){

          //  emit(UploadCoverImageSuccess());
            if (kDebugMode) {
              print(value);
            }

            updateUserData(
                name: name,
                bio: bio,
                phone: phone,
                coverImage: value,
            );

          })
              .catchError((onError){
            emit(UploadCoverImageError());
          });
    })
        .catchError((error){
          emit(UploadCoverImageError());
    });

  }


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getUserData (){

    emit(HomeLoadingState());

    firestore.collection('users').doc(uId).get()
        .then((value) {

         userData = UserData.fromJson(value.data());

         emit(HomeSuccessState());
    })
        .catchError((onError){
          emit(HomeErrorState(onError));
          if (kDebugMode) {
            print(onError);
          }
    });

  }

  List<UserData> userDataList = [];
  void getListOfUsers(){

    emit(GetUserDataSuccess());

    firestore.collection('users')
        .get()
        .then((value){

      for(var userData in value.docs){
        print(userData.id);
        print(value.docs.length);

        userDataList.add(UserData.fromJson(userData.data()));
      }

    }).catchError((onError){
      emit(GetUserDataError());

    });


  }



  createLike(String postId){
    firestore.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userData.uId)
        .set({'like': true})
        .then((value){
      emit(CreateLikePostSusses());
    })
        .catchError((onError){
      emit(CreateLikePostError());
    });
  }

  createComments({
    @required String postId,
    @required String textComment,
  }){

    CommentModel commentModel = CommentModel(

      image: userData.image,
      userName: userData.name,
      textComment: textComment,
      userId: userData.uId

    );
    firestore.collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toFirebase())
        .then((value){
          emit(CreateCommentPostSusses());
    })
        .catchError((onError){
      emit(CreateCommentPostError());

    });

  }


  List <CommentModel> commentData;

  void getComments({String postID}){
    commentData = [];

    firestore.collection('posts').doc(postID).collection('comments').get()
        .then((value){
      emit(GetCommentPostSusses());

      for(var dataInDoc in value.docs){
        print(dataInDoc.id);
        print(value.docs.length);

        commentData.add(CommentModel.fromFireBase(dataInDoc.data()));
      }

    }).catchError((onError){
      emit(GetCommentPostError());

    });

  }

  List <PostData> postData = [];
  List <String> postId = [];
  List <int> getLike=[];
  List <int> getNumberComments = [];


  void getPostsData(){

    firestore.collection('posts').get()
        .then((value){
      for (var element in value.docs) {

        element.reference.collection('comments')
            .get()
            .then((value) {
          getNumberComments.add(value.docs.length);


        }).catchError((onError){

        });

        element.reference.collection('likes')
            .get()
            .then((value) {
          emit(GetPostSuccess());
          getLike.add(value.docs.length);
          postId.add(element.id);
          print("post id $postId");
          postData.add(PostData.fromFireBase(element.data()));

        }).catchError((onError) {});
      }

      emit(GetPostSuccess());

    }).catchError((onError){
      emit(ErrorGetPost(onError.toString()));
    });

  }





  updateUserData({
    @required String name,
    @required String bio,
    @required String phone,
    String profileImage,
    String coverImage,
  }){
    emit(LoadingUpdateUserData());
    UserData updateUserData = UserData(
        name: name,
        phone: phone,
        bio: bio,
        image: profileImage ?? userData.image,
        email: userData.email,
        uId: userData.uId,
        cover:coverImage?? userData.cover
    );


    firestore.collection('users')
        .doc(userData.uId)
        .update(updateUserData.toJson())
        .then((value){

    })
        .catchError((onError){
      emit(UserUpdateDataError());
    });
  }
}