import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/Icons.dart';
import 'package:social_media/shared/style/colors/colors.dart';

import 'Image.dart';
import 'comments.dart';

class singlePost_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).singlePost;
          return
            BuildCondition(
              condition:model!=null ,
              fallback:(context)=> Center(child: CircularProgressIndicator(),) ,
              builder:(context)=>
              Scaffold(
            appBar: AppBar(),
            body:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: defultcolor.withOpacity(0.20),
                            backgroundImage: NetworkImage(model!.image!),
                            radius: 27,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  model.name!,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  '${model.dataTime}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          if (model.uId == SocialCubit.get(context).usermodel!.uId!)
                            PopupMenuButton<int>(
                              onSelected: (int value) {
                                if (value == 1) {
                                  SocialCubit.get(context)
                                      .deletePost(postid: model.Post_id.toString());
                                  print('=============' + model.Post_id.toString());
                                  //SocialCubit.get(context).getPost();

                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(
                                  value: 1,
                                  enabled: true,
                                  child: Text('Delet'),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: .8,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (model.Text != "")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            model.Text!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      if (model.PostImage != "")
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              height: 290,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  NavigatorTo(context,
                                      Image_screen(image: model.PostImage!));
                                },
                                child: Image(
                                  image: NetworkImage(
                                    '${model.PostImage}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      IconBroken.Heart,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${model.Post_Like.length}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ]),
                            ),
                            Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(IconBroken.Chat),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      //'0',
                                      '${SocialCubit.get(context).NComment}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: .8,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              SocialCubit.get(context)
                                  .GetComment(postid: model.Post_id!);
                              NavigatorTo(
                                  context,
                                  Comments_screen(
                                    Post_id: model.Post_id,
                                  ));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: defultcolor.withOpacity(0.1),
                                    backgroundImage: NetworkImage(
                                        '${SocialCubit.get(context).usermodel!.image}'),
                                    radius: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    //height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: .3,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Text('write a comment here ....      ',
                                          style:
                                              Theme.of(context).textTheme.caption),
                                    ),
                            ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          SocialCubit.get(context).ChangelikePost(
                                              postid: model.Post_id!);
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                IconBroken.Heart,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                ' Like ',
                                                style:
                                                    TextStyle(color: Colors.black),
                                              ),
                                             ]),
                                 ),
                                     ],
                                  ),
                                ]),
                          )
                         ],
                       ),
                    ],
                  ),
                ),

              ),

           ),
          );

        });
  }
}
