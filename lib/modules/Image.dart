import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/cubit.dart';
import 'package:social_media/cubit/states.dart';

class Image_screen extends StatelessWidget {

   late String image;

   Image_screen({required this.image}){print(image);}



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:BuildCondition(
              condition:image != '' ,
              builder: (context)=> Card(
                elevation: 10,
                child: Center(
                  child: Image(image: NetworkImage('${image}'),
                  fit: BoxFit.cover,),
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            ) ,

          );
        }
    );
  }
}
