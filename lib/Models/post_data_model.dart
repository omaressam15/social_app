class PostData {

  String name;
  String profileImage;
  String postImage;
  var dateTime;
  String textPost;
  String uId;

  PostData({this.name, this.profileImage, this.postImage,this.dateTime,this.textPost,this.uId});

  PostData.fromFireBase(Map<String,dynamic>json){

    name = json['name'];
    profileImage = json['ProfileImage'];
    postImage = json['PostImage'];
    dateTime = json['DateTime'];
    textPost = json['TextPost'];
    uId = json['uId'];

  }

  Map<String,dynamic>toFireBase(){

    return {

      'name' : name,
      'ProfileImage' : profileImage,
      'PostImage' : postImage,
      'DateTime': dateTime,
      'TextPost':textPost,
      'uId' : uId,
    };

  }


}