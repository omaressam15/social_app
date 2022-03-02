
class UserData{

  String name;
  String email;
  String phone;
  String bio;
  String image;
  String cover;
  String uId;

  UserData({this.name, this.email, this.phone,this.uId,this.image,this.cover,this.bio});

  UserData.fromJson(Map<String,dynamic>json){

    name = json['name'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];

  }

  Map<String,dynamic>toJson(){

    return {

      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'image': image,
      'cover':cover,
      'bio':bio,

    };

  }



}
