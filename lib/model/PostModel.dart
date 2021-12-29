import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/model/CommentModel.dart';

class PostModel{
  String? uId;
  String? name;
  String? image;
  String? PostImage;
  String? Text;
  String? Post_id;
  List<String>Post_Like=[];
  Timestamp? dataTime;
 // List<CommentModel> Post_Comments=[];

  PostModel({this.Text,this.uId,this.image,this.name,this.dataTime,this.PostImage,
    this.Post_id,required this.Post_Like
  });

  PostModel.fromJson(Map<String,dynamic>json)
  {
    uId = json['uId'];
    name = json['name'];
    dataTime = json['dataTime'];
    PostImage = json['PostImage'];
    image = json['image'];
    Text = json['Text'];
    Post_id = json['Post_id'];
    Post_Like = (json['Post_Like'] != null ? List<String>.from(json['Post_Like']) : null)!;


    // json['Post_Comments'].forEach((e){
    //   if(e !=null)
    //     Post_Comments.add(CommentModel.fromJson(e));
    // });

  }

  Map<String,dynamic> toMap()
  {
    return{
      'uId':uId,
      'name':name,
      'image':image,
      'dataTime':dataTime,
      'PostImage':PostImage,
      'Text':Text,
      'Post_id':Post_id,
       'Post_Like':Post_Like.map((e) => e.toString()).toList(),
      // 'Post_Comments':Post_Comments.map((e) => e.toMap()).toList(),
    };
  }

}