import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/modules/home_screen.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/colors/colors.dart';

class posts_screen extends StatelessWidget {
  var TextController = TextEditingController();
//bool LinearIndicator =false;
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<SocialCubit,socialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'CeatePost',
                  style: TextStyle(fontSize: 22),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (state is !SuccessCreatPostState) {
                        // LinearIndicator =true;
                        }
                        if (TextController.text == '' &&
                            cubit.PostImage == null) {
                          toast(
                              text: 'No post anything',
                              state: toastStates.Warning);
                        } else {
                          if (cubit.PostImage == null) {
                            cubit.createPost(
                                Text: TextController.text);
                          } else {
                            cubit.uploadPostImage(
                                dataTime: DateTime.now().toString(),
                                Text: TextController.text);
                          }

                          if (state is SuccessCreatPostState) {
                            TextController.text = '';
                            cubit.RemovePostImage();
                            NavigatorTo(context, home_screen());
                           // LinearIndicator =false;
                          }
                        }
                      },
                      child: Text(
                        'DONE',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ],
              ),
             body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      if (state is LoadingCreatPostState) LinearProgressIndicator(),
                      if (state is LoadingCreatPostState)
                        SizedBox(
                          height: 10.0,
                        ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: defultcolor.withOpacity(0.20),
                            backgroundImage:
                                NetworkImage('${cubit.usermodel!.image}'),
                            radius: 27,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${cubit.usermodel!.name}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: TextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'write what you thinking .....',
                        ),
                        maxLines: 50,
                        minLines: 1,
                      ),

                      if (cubit.PostImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Image(
                                  image: FileImage(cubit.PostImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    cubit.RemovePostImage();
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                          ],
                        ),
                      if (cubit.PostImage == null)
                        SizedBox(
                          height: 30,
                        ),
                      // Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                cubit.getPostImage();
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    Text(
                                      'image',
                                    ),
                                  ]),
                            ),
                          ),
                          // Expanded(
                          //   child: TextButton(
                          //       onPressed: () {},
                          //       child: Text(
                          //         '# tages',
                          //       )),
                          // )
                        ],
                      ),
                    ]),
                  ),
               ),

            );
          }
          //),
    );
  }
}
