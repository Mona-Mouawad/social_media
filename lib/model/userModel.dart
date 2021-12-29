import 'PostModel.dart';

class UserModel{
  String? uId;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? bio;
  String? coverimage;
  String? token;
  List <String> userPost=[];
  bool? isEmailVerified;

  UserModel({this.email,this.uId,this.image,this.name,this.phone,
    this.bio,this.coverimage,this.token,this.isEmailVerified});
 
  UserModel.fromJson(Map<String,dynamic>json)
  {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
    coverimage = json['coverimage'];
    userPost=(json['userPost'] != null ? List<String>.from(json['userPost']) : null)!;
  }

  Map<String,dynamic> toMap()
  {
    return{
      'uId':uId,
      'name':name,
      'image':image,
      'email':email,
      'phone':phone,
      'bio':bio,
      'token':token,
      'isEmailVerified':isEmailVerified,
      'coverimage':coverimage,
      'userPost':userPost.map((e) => e.toString()).toList(),
    };
  }

}