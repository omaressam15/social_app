class ChatData{

  String senderId ;
  String receiverId ;
  String message;
  String dateTime ;

  ChatData({this.senderId, this.receiverId, this.message,this.dateTime});

  ChatData.fromJson(Map<String,dynamic>json){

    senderId = json['SenderId'];
    receiverId = json['ReceiverId'];
    message = json['Message'];
    dateTime = json['DateTime'];

  }

  Map<String,dynamic>toJson(){

    return {

      'SenderId' : senderId,
      'ReceiverId' : receiverId,
      'Message' : message,
      'DateTime' : dateTime,
    };

  }



}