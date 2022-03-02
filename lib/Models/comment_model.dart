class CommentModel {

  String textComment ;

  String image;

  String userName;

  String userId;

  CommentModel({this.textComment, this.image, this.userName,this.userId});


  CommentModel.fromFireBase(Map<String,dynamic>json){

    textComment = json['TextComment'];

    image = json['image'];

    userName = json['UserName'];



  }

  Map<String,dynamic>toFirebase(){

    return{

      'TextComment':textComment,
      'image':image,
      'UserName':userName,
      'userId' :userId,

  };
}

}