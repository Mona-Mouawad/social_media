import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/model/NotificationModel.dart';
import 'package:social_media/modules/chatesDetailsScreen.dart';
import 'package:social_media/modules/singlePost_screen.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/Icons.dart';
import 'package:social_media/shared/style/colors/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, socialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: BuildCondition(
            fallback: (context) => Center(
              child: Text(
                'No Notification yet',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => notificationBuilder(
                  SocialCubit.get(context).Notifications[index], context),
              separatorBuilder: (context, index) => SizedBox(
                height: 0,
              ),
              itemCount: SocialCubit.get(context).Notifications.length,
            ),
            condition: SocialCubit.get(context).Notifications.length > 0,
          ),
        );
      },
    );
  }
}

Widget notificationBuilder(NotificationModel notify, context) {
  return InkWell(
    onTap: ()async {
      if(notify.action =='MESSAGE')
        {
          SocialCubit.get(context).getprofileForUser(notify.senderId!);

          NavigatorTo(context,
              chatsDetailsScreen(usermodel:SocialCubit.get(context).recivermodel));
        }
      else{
         SocialCubit.get(context).getSinglePost(post_id: notify.targetPostUid!);
        NavigatorTo(context, singlePost_screen());
      }

      //(context,SinglePostViewScreen(postUid: notify.targetPostUid,));
    },
    child: Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: defultcolor.withOpacity(0.20),
                    backgroundImage: NetworkImage(notify.senderImage!),
                  ),
                ),

               if(notify.action == 'COMMENT') Icon(
                        Icons.mode_comment,
                        color: Colors.grey,
                        size: 25,
                      ),
               if(notify.action == 'LKE') Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 25,
                      ),
               if(notify.action == 'MESSAGE') Icon(
                  Icons.chat,
                  color: Colors.green,
                  size: 25,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            if(notify.action == 'LIKE')
               Expanded(
              child:
                 Text(
                   '${notify.senderName} Liked your post' ,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.brown,
                    fontWeight: FontWeight.w500),
              ),
            ),
            if(notify.action == 'COMMENT')
              Expanded(
                child:
                Text(
                  '${notify.senderName} Commented on your post',
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500),
                ),
              ),
            if(notify.action == 'MESSAGE')
              Expanded(
                child:
                Text(
                  '${notify.senderName} sent message to you ' ,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500),
                ),
              ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Info_Circle,
                  color: Colors.brown,
                )),

          ],
        ),
      ),
    ),
  );
}
