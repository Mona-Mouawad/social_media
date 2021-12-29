import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel{
  String? uId;
  String? userCuId;
  String? UpostuId;
  String? name;
  String? image;
  String? Comment;
  Timestamp? time;

  CommentModel({this.image,this.name,this.time,this.Comment});

  CommentModel.fromJson(Map<String,dynamic>json)
  {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    time = json['time'];
    Comment = json['Comment'];
    userCuId = json['userCuId'];
    UpostuId = json['UpostuId'];

  }

  Map<String,dynamic> toMap()
  {
    return{
      'uId':uId,
      'userCuId':userCuId,
      'UpostuId':UpostuId,
      'name':name,
      'image':image,
      'time':time,
      'Comment':Comment,
    };
  }


}