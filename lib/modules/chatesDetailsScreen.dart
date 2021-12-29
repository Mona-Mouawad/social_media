import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/model/userModel.dart';
import 'package:social_media/modules/Image.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/colors/colors.dart';

class chatsDetailsScreen extends StatelessWidget {
  UserModel? usermodel;

  chatsDetailsScreen({this.usermodel});

  var message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BuildCondition(
      fallback: (context) => Container(
        color: Colors.white,
      ),
      condition: usermodel != null,
      builder: (context) =>  Builder(builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(reciverrID: usermodel!.uId!);
        return BlocConsumer<SocialCubit, socialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SocialCubit.get(context);
              return Scaffold(
                    appBar: AppBar(
                      title: InkWell(
                        onTap: () {
                          NavigatorTo(
                              context, Image_screen(image: usermodel!.image!));
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: defultcolor.withOpacity(0.1),
                              backgroundImage: NetworkImage('${usermodel!.image}'),
                              radius: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${usermodel!.name}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (cubit.usermodel!.uId ==
                                      cubit.messages[index].senderId)
                                    return send1(cubit.messages[index]);
                                  return send2(cubit.messages[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 2),
                                itemCount: cubit.messages.length),
                          ),
                          // Spacer(),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: .7,
                                  color: defultcolor.withOpacity(.1),
                                )),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(
                                      controller: message,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Write your message here ...'),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: defultcolor.withOpacity(.3),
                                  width: 50,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (message.text != '') {
                                        SocialCubit.get(context).sentMassage(
                                            senderID: uid,
                                            reciverrID: usermodel!.uId!,
                                            time: DateTime.now().toString(),
                                            message: message.text);

                                        cubit.sendNotification(
                                            token: usermodel!.token.toString(),
                                            title: 'New Message ',
                                            body: '${cubit.usermodel!.name} sent message to you');
                                      }
                                      message.text = '';
                                    },
                                    child: Icon(
                                      Icons.send,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
              );
            });
      }),
    );
  }

  Widget send1(model) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 30),
        child: Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(8),
                bottomEnd: Radius.circular(10),
                bottomStart: Radius.circular(8),
              ),
              color: defultcolor.withOpacity(
                .3,
              ),
            ),
            child: Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  model!.megessa!,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget send2(model) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 30),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(8),
                bottomEnd: Radius.circular(8),
              ),
              color: Colors.grey[400],
            ),
            child: Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  model!.megessa!,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
