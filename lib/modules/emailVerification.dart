import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/cubit/emailVerificationCubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/modules/layout.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/style/colors/colors.dart';
class EmailVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmailVerificationCubit(),
      child: BlocConsumer<EmailVerificationCubit,socialStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = EmailVerificationCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: defultcolor,
                        borderRadius: BorderRadius.circular(75.0)),

                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('Email Confirmation',style:TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.w800,)),
                  SizedBox(height: 10.0,),
                //  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing',),
                  SizedBox(height: 45.0,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child:

                    state is LoadingSendVerificationMailState ?
                    CircularProgressIndicator()
                        : cubit.isEmailSent ?
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline,color: Colors.white,),
                        Text('Email Verification Sent',style:TextStyle(color: Colors.white,fontSize: 12.0)),
                        SizedBox(width: 10.0,),
                        TextButton(onPressed: (){cubit.sendEmailVerification();}, child: Text('Send again',style: TextStyle(color: defultcolor),))],)
                        :defultButton(ontap: (){cubit.sendEmailVerification();},
                        text: 'Send Email',),
                  ),

                  SizedBox(height: 15.0,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child:

                    cubit.isEmailSent ?
                    defultButton(ontap: (){
                      cubit.reloadUser().then((value) {
                        if(cubit.isEmailVerified)
                          NavigatorAndFinish(context, layout_screen());
                        else{
                          toast(text: 'Please Verify Your Email',
                            state:toastStates.Warning,);
                        }
                      });

                    }, text: 'Verified, Go Home',)
                        : defultButton(ontap: (){}, text: 'Verified, Go Home',),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}