class CommentModel {

  String textComment ;

  String timeAgo;

  String image;

  String userName;

  String userId;

  CommentModel({this.textComment, this.image, this.userName,this.timeAgo,this.userId});


  CommentModel.fromFireBase(Map<String,dynamic>json){

    textComment = json['TextComment'];

    image = json['image'];

    userName = json['UserName'];

    timeAgo = json['timeAgo'];


  }

  Map<String,dynamic>toFirebase(){

    return{

      'TextComment':textComment,
      'image':image,
      'UserName':userName,
      'userId' :userId,
      'TimeAgo': timeAgo,

  };
}

}