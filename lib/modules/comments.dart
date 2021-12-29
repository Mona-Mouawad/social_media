import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/colors/colors.dart';

import 'Image.dart';

class Comments_screen extends StatelessWidget {
  var message = TextEditingController();
  String? Post_id;

  Comments_screen({this.Post_id});

  @override
  Widget build(BuildContext context) {
    print(Post_id!);
    return BlocConsumer<SocialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                SizedBox(
                  height: 2,
                ),
                // if (cubit.comment.length > 0)
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              BulidComment(cubit.comment[index], context,index),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: cubit.comment.length),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: defultcolor.withOpacity(.1),
                      )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: message,
                            minLines: 1,
                            maxLines: 100,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write your comment here ...'),
                          ),
                        ),
                      ),
                      Container(
                        color: defultcolor.withOpacity(.3),
                        width: 50,
                        child: MaterialButton(
                          onPressed: () {
                            if (message.text != '') {
                              SocialCubit.get(context).CommentPost(
                                  postid: Post_id!,
                                  text: message.text);
                              SocialCubit.get(context)
                                  .GetComment(postid: Post_id!);
                              message.text = '';
                              SocialCubit.get(context).getPost();
                            }
                          },
                          child: Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  Widget BulidComment(model, context,index) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  NavigatorTo(context, Image_screen(image: model!.image));
                },
                child: CircleAvatar(
                  backgroundColor: defultcolor.withOpacity(0.1),
                  backgroundImage: NetworkImage(model!.image),
                  radius: 27,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(8),
                      bottomEnd: Radius.circular(10),
                      bottomStart: Radius.circular(8),
                    ),
                    color: defultcolor.withOpacity(
                      .05,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model!.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                model!.Comment,
                                maxLines: 100,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.bodyText1!.copyWith(
                                          height: 1.6,
                                          fontSize: 15, ),

                              ),
                            ],
                          ),
                        ),
                       Spacer(),
                        if(SocialCubit.get(context).comment[index].userCuId==SocialCubit.get(context).usermodel!.uId )
                           PopupMenuButton<int>(
                          onSelected: (int value){
                            if (value ==1) {
                              SocialCubit.get(context).deleteComment(
                                  uid: SocialCubit
                                      .get(context)
                                      .comment[index].uId.toString(),
                                  postid: Post_id.toString());
                              print('=============' + SocialCubit
                                  .get(context)
                                  .comment[index].uId.toString());
                              SocialCubit
                                  .get(context).getPost();
                            }
                            if (value ==2) {
                              message.text=SocialCubit.get(context).comment[index].Comment.toString();
                              SocialCubit.get(context).deleteComment(
                                  uid: SocialCubit
                                      .get(context)
                                      .comment[index].uId.toString(),
                                  postid: Post_id.toString());
                              print('=============' + SocialCubit
                                  .get(context)
                                  .comment[index].uId.toString());
                              SocialCubit
                                  .get(context).getPost();
                            }  },
                            itemBuilder: (BuildContext context)=>[
                              const PopupMenuItem(
                                value: 1,
                                enabled: true,
                                child:Text('Delet') ,

                              ),
                              const PopupMenuItem(
                                value: 2,
                                enabled: true,
                                child:Text('Edit') ,

                              ),

                            ],),
                         if(SocialCubit.get(context).comment[index].UpostuId==SocialCubit.get(context).usermodel!.uId&&
                             SocialCubit.get(context).comment[index].userCuId!=SocialCubit.get(context).usermodel!.uId )
                           PopupMenuButton<int>(
                            onSelected: (int value){
                              if (value ==1) {
                                SocialCubit.get(context).deleteComment(
                                    uid: SocialCubit
                                        .get(context)
                                        .comment[index].uId.toString(),
                                    postid: Post_id.toString());
                                print('=============' + SocialCubit
                                    .get(context)
                                    .comment[index].uId.toString());
                                SocialCubit
                                    .get(context).getPost();
                              }
                             },
                            itemBuilder: (BuildContext context)=>[
                              const PopupMenuItem(
                                value: 1,
                                enabled: true,
                                child:Text('Delet') ,

                              ),

                            ],),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      );

}
