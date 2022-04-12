import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/comment_model.dart';
import 'package:social_app/Models/post_data_model.dart';
import 'package:social_app/Models/user_data_model.dart';
import 'package:social_app/components.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/dioHelper/dio_network.dart';
import 'package:social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../Models/chatting.dart';
import '../../../Models/notification.dart';
import '../../../dioHelper/url.dart';
import '../../AddNewPostSceen/add_new_post_screen.dart';
import '../../chats/chat_screen.dart';
import '../../displayPickImageChatting.dart';
import '../../feeds/feed_screen.dart';
import '../../settings/setting_screen.dart';
import 'home_state.dart';

class CubitHome extends Cubit<StatesHome>{

  CubitHome() : super (HomeInitialState());

  static CubitHome get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  double progress = 0.0;

  UserData userDataModel ;


  List <Widget> screens = [

    const FeedScreen(),

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


    if(index ==1){

      getListOfUsers();
      updateUserTokenDevice();
    }

    if(index==2){
      emit(ScreenNewPost());

    }else{
      currentIndex = index;
      emit(ChangeButtonNavigationBar());
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //3ashan lama yd5ol 3ala chats y3ml update le device token
  // 3ashan al devise token byt3'ayr lma al user y3ml logout
  updateUserTokenDevice(){

    UserData updateUserDataTokenDevice = UserData(
      name: userDataModel.name,
      phone: userDataModel.phone,
      bio: userDataModel.bio,
      image: userDataModel.image,
      email: userDataModel.email,
      uId: userDataModel.uId,
      cover: userDataModel.cover,
      tokenDevice: tokenDevices,

    );


    firestore.collection('users')
        .doc(userDataModel.uId)
        .update(updateUserDataTokenDevice.toJson())
        .then((value){
      emit(LoadingUpdateDeviceToken());

    })
        .catchError((onError){
      emit(LoadingUpdateDeviceTokenError());
    });
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

  File chattingImage;
  // Pick an image
  Future pickerChatImage({BuildContext context, String receiverId}) async {
    final XFile image = await pickerImage.pickImage(source: ImageSource.gallery);

    if(image !=null){
      emit(PickerChattingImageSuccess());
      chattingImage = File(image.path);
      navigate( DisplayPickImage(imagePick: chattingImage,receiverId: receiverId),context,
      );

    }else{
      emit(PickerChattingImageError());
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

      })
    ).catchError((error){
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
        name: userDataModel.name,
        profileImage: userDataModel.image,
        uId: userDataModel.uId,
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

void sendNotification({String title,String body,String token}){

    SendNotification notification = SendNotification(
      tokenNotification: token,
      body : body,
      title: title
    );

    DioHelper.postData(
        url: baseUrl,
        data: notification.toJson())
        .then((value) {
          print('print data$value.data');
          emit(SendNotificationSuccess());
    }).catchError((onError){
      emit(SendNotificationError());

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
        image: profileImage ?? userDataModel.image,
        email: userDataModel.email,
        uId: userDataModel.uId,
        cover:coverImage?? userDataModel.cover,

    );


    firestore.collection('users')
        .doc(userDataModel.uId)
        .update(updateUserData.toJson())
        .then((value){

    })
        .catchError((onError){
      emit(UserUpdateDataError());
    });
  }

  void getUserData (){

    emit(HomeLoadingState());

    firestore.collection('users').doc(uId).get()
        .then((value) {

         userDataModel = UserData.fromJson(value.data());

         emit(HomeSuccessState());
    })
        .catchError((onError){
          emit(HomeErrorState(onError));
          if (kDebugMode) {
            print(onError);
          }
    });

  }

  List<UserData> userDataList;
  void getListOfUsers(){
    emit(LoadingGetUserDataSuccess());

    userDataList =[];
    firestore.collection('users')
        .snapshots()
        .listen((value){
      emit(GetUserDataSuccess());

      for(var usersData in value.docs){
        print(usersData.id);
        print(value.docs.length);
        if(usersData.data()['uId']!= userDataModel.uId) {
          userDataList.add(UserData.fromJson(usersData.data()));
        }

      }

    });
  }


  createLike(String postId){
    firestore.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userDataModel.uId)
        .set({'like': true})
        .then((value){

          print('is like print ${isLikes[postId]}');
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

      image: userDataModel.image,
      userName: userDataModel.name,
      textComment: textComment,
      userId: userDataModel.uId

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




  List <CommentModel> commentData=[];

  void getComments({String postID}){

    firestore.collection('posts')
        .doc(postID)
        .collection('comments')
        .snapshots().
    listen((event) {
      commentData = [];

      for(var dataInDoc in event.docs){
        print(dataInDoc.id);
        print(event.docs.length);
        commentData.add(CommentModel.fromFireBase(dataInDoc.data()));
      }
      emit(GetCommentPostSusses());

    });
  }

  List <PostData> postData = [];
  List <String> postId = [];
  Map<String, int> likesNumber = {};
  Map<String, bool> isLikes = {};
  Map<String, int> commentsNumber = {};


  void getPostsData(){

    firestore.collection('posts')
        .orderBy('DateTime')
        .snapshots()
        .listen((value){

          postData =[];
      for (var element in value.docs) {

        element.reference.collection('comments')
            .get()
            .then((value) {
          commentsNumber.addAll({element.id: value.docs.length});
          print('number comment ${commentsNumber.length}');

        }).catchError((onError){

        });

        element.reference.collection('likes')
            .doc(uId)
            .get()
            .then((value) {
              print('BLBLB ${userDataModel.uId}${value.data()['like']}');
          isLikes.addAll({userDataModel.uId: value.data()['like']??false});


        }).catchError((onError){

        });

        element.reference.collection('likes')
            .get()
            .then((value) {

          emit(GetPostSuccess());
          likesNumber.addAll({element.id:value.docs.length});

          postId.add(element.id);
          print("post id $postId");

          postData.add(PostData.fromFireBase(element.data()));

        }).catchError((onError) {
          emit(GetPostError());

        });
      }
    });
  }
void sendMessageChattingWithPhoto({
  String textMassage,
  String receiverID,
  String time,
  String date,
  String dateTime,
}){
    emit(LoadingSendMessagePhoto());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('chatting_Image/${Uri.file(chattingImage.path).pathSegments.last}')
        .putFile(chattingImage)
        .snapshotEvents.listen((value){
          progress = value.bytesTransferred.toDouble()/value.totalBytes.toDouble();

          print('Uploading ${(progress * 100).toStringAsFixed(2)} %');

          value.ref.getDownloadURL()
              .then((value){

            emit(SendChattingImageSuccess());

            sendMessageChatting(
              dateTime: dateTime,
              date: date,
              textMassage: textMassage,
              imageChatting: value,
              receiverID: receiverID,
              time: time,
            );

          }).catchError((onError){
            emit(SendChattingImageError());

          });
    });

}

void sendMessageChatting({
  String textMassage,
  String receiverID,
  String time,
  String date,
  String dateTime,
  String imageChatting,
}){

  ChatData chatData = ChatData(
    message:  textMassage,
    senderId: userDataModel.uId,
    receiverId: receiverID ,
    time: time,
    date: date,
    dateTime: dateTime,
    imageChatting: imageChatting??'',
  );

  firestore.collection('users').
  doc(userDataModel.uId).
  collection('chats').
  doc(receiverID).
  collection('messages').
  add(chatData.toJson()).
  then((value) {
    emit(SendChattingMessagingSuccess());
  }).catchError((onError){
    emit(SendChattingMessagingError());
  });

  firestore.collection('users').
  doc(receiverID).
  collection('chats').
  doc(userDataModel.uId).
  collection('messages').
  add(chatData.toJson()).
  then((value) {
    emit(SendChattingMessagingSuccess());
  }).catchError((onError){
    emit(SendChattingMessagingError());
  });

}

List<ChatData>listOfChats=[] ;
void getMessageChatting({String receiverId}){

    firestore.collection('users').
    doc(userDataModel.uId).
    collection('chats').
    doc(receiverId).
    collection('messages').
    orderBy('dateTime').
    snapshots().
    listen((event) {
      listOfChats= [];
      for(var dataChats in event.docs){
        listOfChats.add(ChatData.fromJson(dataChats.data()));
      }
      emit(GetChattingMessagingSuccess());
    });
}

}