import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/model/userModel.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/colors/colors.dart';

import 'chatesDetailsScreen.dart';


class chats_screen extends StatelessWidget {
  const chats_screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,socialStates>(
        listener:(context,state){} ,
        builder:(context,state){
          var cubit=SocialCubit.get(context);
          return BuildCondition(
            condition:cubit.user.length > 0 ,
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
            builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>BuildItems(cubit.user[index],context),
                separatorBuilder:(context,index)=> myDivited(),
                itemCount: cubit.user.length),
          );
        }

    );
  }

  Widget BuildItems(UserModel model,context)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
    child: InkWell(
      onTap: (){
        print(model.uId);
        NavigatorTo(context, chatsDetailsScreen(usermodel: model,));
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: defultcolor.withOpacity(0.1),
            backgroundImage: NetworkImage('${model.image}'),
          radius: 30,),
          SizedBox(width: 17,),
          Text('${model.name}',
          style: Theme.of(context).textTheme.headline5,),
        ],
      ),
    ),
  );

}