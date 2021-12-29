import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_media/cubit/states.dart';
import 'package:social_media/model/ChatModel.dart';
import 'package:social_media/model/CommentModel.dart';
import 'package:social_media/model/NotificationModel.dart';
import 'package:social_media/model/PostModel.dart';
import 'package:social_media/model/userModel.dart';
import 'package:social_media/modules/chats_screen%20.dart';
import 'package:social_media/modules/home_screen.dart';
import 'package:social_media/modules/posts_screen%20.dart';
import 'package:social_media/modules/profile.dart';
import 'package:social_media/modules/users_screen.dart';
import 'package:social_media/shared/component.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SocialCubit extends Cubit<socialStates> {
  SocialCubit() : super(socialinitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    home_screen(),
    chats_screen(),
    posts_screen(),
    //users_screen(),
    profile_screen()
  ];

  List<String> title = ['Feed', 'Chats', 'Posts'
   // , 'Users'
    , 'Profile'];

  void changeBottomindex(index, context) {
    currentIndex = index;
    if (currentIndex == 1) {
      getAllusers();
    }
    if (currentIndex == 2) {
      NavigatorTo(context, posts_screen());
      currentIndex = 0;
    }

    emit(ChangeBottomstate());
  }

  UserModel? usermodel;

  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future<void> getprofileImage() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = File(value!.path);
      print(value.path);
      emit(SuccessGetImageprofileState());
    }).catchError((onError)
        {
      print('No image selected');
      emit(ErrorGetImageprofileState());
    });
  }

  Future<void> getcoverImage() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      coverImage = File(value!.path);
      print(value.path);
      emit(SuccessGetImageCoverState());
    }).catchError((onError)
        {
      print('No image selected');
      emit(ErrorGetImageCoverState());
    });
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(LoadingUpdateprofileUserState());
        FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .update({'image': value}).then((value) {
          getprofile();
          emit(SuccessUpdateUserState());
        }).catchError((onError)
            {
          emit(ErrorUpdateUserState(onError.toString())
            );
          print( " <<<< "+onError.toString()+ " >>>>> ");
        });
      });
    }).catchError((onError)
        {
      emit(ErrorUploadImageprofiState(onError.toString())
        );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    }).catchError((onError)
        {
      emit(ErrorUploadImageprofiState(onError.toString())
        );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    });
  }

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(LoadingUpdatecoverUserState());
        FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .update({'coverimage': value}).then((value) {
          getprofile();
          emit(SuccessUpdateUserState());
        }).catchError((onError)
            {
          emit(ErrorUpdateUserState(onError.toString())
            );
        });
      });
    }).catchError((onError)
        {
      emit(ErrorUploadImageCoverState(onError.toString())
        );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    }).catchError((onError)
        {
      emit(ErrorUploadImageCoverState(onError.toString())
        );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(LoadingUpdateUserState());
    FirebaseFirestore.instance.collection('user').doc(uid).update({
      'name': name,
      'phone': phone,
      'bio': bio,
    }).then((value) {
      print(uid);
      print(usermodel!.uId);
      print(name);
      print(phone);
      getprofile();
      emit(SuccessUpdateUserState());
      getPostsIDs_User();
      print( " <<<< "+" >>>>> ");
    }).catchError((onError)
        {
      emit(ErrorUpdateUserState(onError.toString())
        );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    });
  }

  void getprofile() {
    emit(LoadingGetUserState());
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      var data = value.data();
      usermodel = UserModel.fromJson(data!);
      emit(SuccessGetUserState());
      getPostsIDs_User();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserState(error.toString()));
    });
  }

  UserModel? recivermodel;
  void getprofileForUser (
   String reciverID,
      ) {
    FirebaseFirestore.instance.collection('user').doc(reciverID).get().then((value) {
      var data = value.data();
      recivermodel = UserModel.fromJson(data!);
      emit(SuccessGetUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserState(error.toString()));
    });
  }

  List<UserModel> user = [];

  void getAllusers() {
    emit(LoadingGetAllUserState());
    user = [];
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != usermodel!.uId)
          user.add(UserModel.fromJson(element.data()));
      });
      emit(SuccessGetAllUserState());
    }).catchError((onError){
      emit(ErrorGetAllUserState(onError.toString()) );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    });
  }

  void sentMassage({
    required String senderID,
    required String reciverrID,
    required String time,
    required String message,
  }) {
    ChatModel Model = ChatModel(
        megessa: message,
        reciverId: reciverrID,
        senderId: senderID,
        time: time);
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('chats')
        .doc(reciverrID)
        .collection('messages')
        .add(Model.toMap())
        .then((value) {
      emit(SuccessSentMassageState());
      sendNotifications(action: 'MESSAGE',dateTime: DateTime.now().toString(),
          receiverUid:reciverrID ,targetPostUid: '');
    }).catchError((onError)
        {
      emit(ErrorSentMassageState(onError.toString())
        );
    });

    FirebaseFirestore.instance
        .collection('user')
        .doc(reciverrID)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .add(Model.toMap())
        .then((value) {
      emit(SuccessSentMassageState());
    }).catchError((onError)
        {
      emit(ErrorSentMassageState(onError.toString())
        );
    });
  }

  List<ChatModel> messages = [];
  void getMessage({
    required String reciverrID,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('chats')
        .doc(reciverrID)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(SuccessGettMassageState());
    });

  }



  void createPost({
    String? PostImage,
    required String Text,
  }) {
    emit(LoadingCreatPostState());
    PostModel Model = PostModel(
      image: usermodel!.image,
      name: usermodel!.name,
      uId: usermodel!.uId,
      PostImage: PostImage ?? '',
      // tags: tags ?? '',
      Text: Text,
       Post_Like: [],
      dataTime: Timestamp.now()

    );
    FirebaseFirestore.instance
        .collection('Post')
        .add(Model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('Post').doc(value.id).update({'Post_id':value.id});

        FirebaseFirestore.instance
            .collection('user').doc(uid).update(
            {
              'userPost' : FieldValue.arrayUnion([value.id])
            }).then((value) {
              getPost();
        emit(SuccessCreatPostState());

      });
    }).catchError((onError)
        {
      emit(ErrorCreatPostState(onError.toString())
        );
      print( " <<<< "+onError.toString()+ " >>>>> ");
    });
  }

  File? PostImage;
  Future<void> getPostImage() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      PostImage = File(value!.path);
      print(value.path);
      emit(SuccessGetPostImagerState());
    }).catchError((onError)
        {
      print('No image selected');
      emit(ErrorGetPostIImagerState());
    });
  }

  void uploadPostImage({
    required String dataTime,
    required String Text,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Post/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(Text: Text, PostImage: value);
      });
    }).catchError((onError)
        {
      emit(ErrorUploadPostIImageState(onError.toString()));
      print( " <<<< "+onError.toString()+ " >>>>> ");
    }).catchError((onError)
        {
      emit(ErrorUploadPostIImageState(onError.toString()));
      print( " <<<< "+onError.toString()+ " >>>>> ");
    });
  }

  void RemovePostImage() {
    PostImage = null;
    emit(SuccessRemovePostImageState());
  }

  List<PostModel> post = [];

  List <int> NumComment=[];

  void getPost() {
    post = [];
    NumComment=[];
    emit(LoadingGetPostState());
    FirebaseFirestore.instance
        .collection('Post')
        .orderBy('dataTime',descending: true)
    //   .snapshots().listen((event) {event
    .get().then((value) {value
      .docs.forEach((element) {
      post = [];
      NumComment=[];
            element.reference.collection('Comment').get()
            .then((value) {

          NumComment.add(value.docs.length);
          post.add(PostModel.fromJson(element.data()));
        });
        emit(SuccessGetPostState());
      });
    });
  }

  void deletePost({
    required String postid,
  })
  {
    FirebaseFirestore.instance.collection('Post')
        .doc(postid).delete()
        .then((value) {emit(SuccessDeletPosttState());})
        .catchError((onError)
        {emit(ErrorDeletPosttState(onError.toString())
        );
        print( " <<<< "+onError.toString()+ " >>>>> ");});
  }

  List<String> postUID_user = []  ;
  List<PostModel> post_user =[] ;
  
  Future<void> getPostsIDs_User () async{
    await FirebaseFirestore.instance
    . collection('user')
        .doc(uid)
        .get().then((value) {
      postUID_user = List<String>.from(value.data()!['userPost']);
      print('this post user are : $postUID_user');
    }).then((value) =>
        UpdataPost_userData());
  }

  void GetUserPostData()
  {
    postUID_user.forEach((element) {
      print( "======="+element+ " >>>>> ");
      FirebaseFirestore.instance.collection('Post')
          .doc(element).get().then((value) {
        post_user.add(PostModel.fromJson(value.data()!));
        print(value.data());
        print(value);

        emit(SuccessGetPosts_userData());
      }).catchError((onError)
      {emit(ErrorGetPosts_userData(onError.toString())
      );
      print( " <<<< "+onError.toString()+ " >>>>> ");});
    });
  }
  

  void UpdataPost_userData()
  {
    //getPosts_User();
    postUID_user.forEach((element) {
     // print( "======="+element+ " >>>>> ");
      FirebaseFirestore.instance.collection('Post')
          .doc(element).update({
        'name': usermodel!.name,
        'image': usermodel!.image, }
      ).then((value) {
       //getPost();
      emit(SuccessUpdataPost_userDataState());
    }).catchError((onError)
    {emit(ErrorUpdataPost_userDataState(onError.toString())
    );
    print( " <<<< "+onError.toString()+ " >>>>> ");});
  });
        }
String receiverUid='';


  void likePost({
  required String postid
})
  {
    FirebaseFirestore.instance.collection('Post')
        .doc(postid).update({
    'Post_Like':FieldValue.arrayUnion([usermodel!.uId])})
        .then((value) {
          post.forEach((element) {
            if(element.Post_id==postid)

              element.Post_Like.add(usermodel!.uId!);
           });
          emit(SuccessLikePostState());
          getSinglePost(post_id: postid);
          sendNotifications(action: 'LIKE',dateTime: DateTime.now().toString(),
          receiverUid:receiverUid ,targetPostUid: postid);
    })
        .catchError((onError)
        {emit(ErrorLikePostState(onError.toString())
        );  print( " <<<< "+onError.toString()+ " >>>>> ");});
  }

  void UNlikePost({
    required String postid
  })
  {
    FirebaseFirestore.instance.collection('Post')
        .doc(postid).update({
      'Post_Like':FieldValue.arrayRemove([usermodel!.uId])})
        .then((value) {
      post.forEach((element) {
        if(element.Post_id==postid)
          // element.Post_Like.forEach((element) {
          //   if(element ==usermodel!.uId!)
          // })
          element.Post_Like.remove(usermodel!.uId!);
      });
      emit(SuccessUNLikeState());
    })
        .catchError((onError)
        {emit(ErrorUNLikeState(onError.toString())
        );  print( " <<<< "+onError.toString()+ " >>>>> ");});
  }

  List<String> postLikesUID = []  ;
  Future<void> getPostLikes (String? postID) async{
    await FirebaseFirestore.instance
        .collection('Post')
        .doc(postID!)
        .get().then((value) {
      postLikesUID = List<String>.from(value.data()!['Post_Like']);
      print('this post likes are : $postLikesUID');
    });
  }

PostModel? postmodel;
  void ChangelikePost({
    required String postid
  })
  {
    getPostLikes(postid).then((value) {
      postLikesUID.contains(usermodel!.uId) ?UNlikePost(postid: postid) : likePost(postid: postid);
    });
  }


  void CommentPost({
    required String postid,
    required String text,
   // required String time,
  })
  {
    getSinglePost(post_id: postid);
    FirebaseFirestore.instance.collection('Post')
        .doc(postid).collection('Comment').add({
      'Comment': text,
      'name': usermodel!.name,
      'image':usermodel!.image,
      'time':Timestamp.now(),
      'UpostuId':receiverUid,
      'userCuId':usermodel!.uId,
      })
        .then((value) {
      FirebaseFirestore.instance.collection('Post')
          .doc(postid).collection('Comment').doc(value.id).update({'uId':value.id}).then((value) {
      emit(SuccessCommentPostState());

      sendNotifications(action: 'COMMENT',dateTime: DateTime.now().toString(),
          receiverUid:receiverUid ,targetPostUid: postid);
    });
    })
        .catchError((onError)
        {emit(ErrorCommentPostState(onError.toString())
        );  print( " <<<< "+onError.toString()+ " >>>>> ");});
  }

CommentModel? commentmodel;
List<CommentModel>comment=[];

  void GetComment({required String postid,}){
    FirebaseFirestore.instance.collection('Post').doc(postid)
        .collection('Comment').orderBy('time').
    snapshots().listen((event) {
      comment=[];
    event.docs.forEach((element) {
        comment.add(CommentModel.fromJson(element.data()));
    });


          emit(SuccessGetCommentPostState());
    });

  }

  void deleteComment({
  required String uid,
  required String postid,
})
  {
   FirebaseFirestore.instance.collection('Post')
       .doc(postid).collection('Comment').doc(uid).delete()
       .then((value) {emit(SuccessDeletCommentState());})
       .catchError((onError)
       {emit(ErrorDeletCommentState(onError.toString())
       );  print( " <<<< "+onError.toString()+ " >>>>> ");});
  }

  void sendNotifications({
    required String? action,
    required String? targetPostUid,
    required String? receiverUid,
    required String? dateTime,
  }) {
    if (receiverUid != usermodel!.uId) {
      NotificationModel notify = NotificationModel(
          action: action,
          reciverId: receiverUid,
          senderName: usermodel!.name,
          senderImage: usermodel!.image,
          senderId: usermodel!.uId,
          targetPostUid: targetPostUid,
          time: dateTime,
          seen: false);

      FirebaseFirestore.instance
          .collection('user')
          .doc(receiverUid)
          .collection('notifications')
          .add(notify.toMap())
          .then((value) {
        emit(SuccessSendNotifications());
      }).catchError((error) {
        emit(SuccessSendNotifications());
      });
    }
  }

  List<NotificationModel> Notifications = [];
  void getNotifications() {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      Notifications = [];
      event.docs.forEach((element) {
        Notifications.add(NotificationModel.fromJson(element.data()));
      });
    });
    emit(SuccessGetNotifications());
  }

  PostModel? singlePost;
  int NComment=0;
  void getSinglePost(
  {required String post_id})
  {
    singlePost=null;
    emit(LoadingGetSinglePostState());
    FirebaseFirestore.instance
        .collection('Post').doc(post_id).get()
        .then((value) {
      value.reference.collection('Comment').get()
          .then((value2) {
        NComment=value2.docs.length;
      singlePost=PostModel.fromJson(value.data()!);
        receiverUid=singlePost!.uId!;
      emit(SuccessGetSinglePostState());
    });

  });
        }
  
  var ServerToken ='AAAAg_MvCPA:APA91bFXLqKfs7f4V82SiZc0jBx5U0udgJzv4FboDwaUMS4xZmZPUtUoWTC2TgNRCCbBgPPQnTEFdld7T7t5geQQ_4EUolWROWJwnssyqqaF_fC5LZPJei0ODNnN8R7Qgj0MSh4we3Em';

  void sendNotification({
  required String token,
  required String title,
  required String body,
})async {
    await http.post(Uri.parse('https://fcm.geogleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Key=$ServerToken',
        },
        body: jsonEncode(<String, dynamic>{

          'notification': <String, dynamic>{
            "title": title,
            "body": body,
            "sound": "default",
          },
          "priority": "HIGH",
          "data": <String, dynamic>
          {
            "type": "order",
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          },
          "to": token,

        })
    );
  }



    // "android":
    // {
    // "priority":"HIGH",
    // "notification":
    // {
    // "notification_priority":"PRIORITY_MAX",
    // "sound":"default",
    // "default_sound":true,
    // "default_vibrate_timings":true,
    // "default_light_settings":true
    // }
    // },



}
