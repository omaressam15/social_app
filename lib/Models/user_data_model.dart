
class UserData{

  String name;
  String email;
  String phone;
  String bio;
  String image;
  String cover;
  String tokenDevice;

  String uId;

  UserData({this.name,this.tokenDevice, this.email, this.phone,this.uId,this.image,this.cover,this.bio});

  UserData.fromJson(Map<String,dynamic>json){

    name = json['name'];
    cover = json['cover'];
    image = json['image'];
    tokenDevice = json['tokenDevice'];
    bio = json['bio'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];

  }

  Map<String,dynamic>toJson(){

    return {

      'name' : name,
      'tokenDevice' :tokenDevice,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'image': image,
      'cover':cover,
      'bio':bio,

    };

  }



}
