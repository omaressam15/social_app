class ChatData{

  String senderId ;
  String receiverId ;
  String message;
  String time;
  String date;
  String dateTime;
  String imageChatting;

  ChatData({this.dateTime,this.senderId, this.receiverId, this.message,this.time,this.date, this.imageChatting});

  ChatData.fromJson(Map<String,dynamic>json){

    senderId = json['SenderId'];
    receiverId = json['ReceiverId'];
    message = json['Message'];
    time = json['time'];
    date = json['date'];
    dateTime = json['dateTime'];
    imageChatting = json['ImageChatting'];

  }

  Map<String,dynamic>toJson(){

    return {

      'SenderId' : senderId,
      'ReceiverId' : receiverId,
      'Message' : message,
      'time' : time,
      'date' : date,
      'dateTime' : dateTime,
      'ImageChatting' : imageChatting,
    };

  }



}