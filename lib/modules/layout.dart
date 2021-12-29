import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/modules/notification_screen.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/Icons.dart';
import 'package:social_media/shared/style/colors/colors.dart';

class layout_screen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return //Scaffold();
      BlocConsumer<SocialCubit,socialStates>(
         listener: (context, state) {},
          builder: (context, state) {
          var Cubit = SocialCubit.get(context);
          return Scaffold(

                appBar: AppBar(
                  title: Text(
                    Cubit.title[Cubit.currentIndex],
                    style: TextStyle(fontSize: 26),

                  ),
                  actions: [
                    IconButton(onPressed: (){
                      Cubit.getNotifications();
                      NavigatorTo(context, NotificationScreen());
                    }, icon:Icon( IconBroken.Notification)
                    ), ],
                ),
                body: Cubit.screens[Cubit.currentIndex],

                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: Cubit.currentIndex,
                  onTap: (currenindex) {
                    Cubit.changeBottomindex(currenindex, context);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'HOME'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.chat), label: 'Chat'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.upload), label: 'posts'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.supervised_user_circle),
                    //     label: 'users'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'profile')
                  ],
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: defultcolor,
               ),
               );
             },
           );
        //    )

  }
}
