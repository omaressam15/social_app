class SendNotification {

  String tokenNotification;
  String title;
  String body;


  SendNotification({this.tokenNotification, this.title, this.body});

  Map<String,dynamic>toJson(){

    return {

      "to": tokenNotification,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": {
        "url": "<url of media image>",
        "dl": "<deeplink action on tap of notification>"
      }

    };

  }

}