import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/LoginCubit.dart';
import 'package:social_media/cubit/RegisterCubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/modules/layout.dart';
import 'package:social_media/modules/registerscreen.dart';
import 'package:social_media/shared/component.dart';

import 'layout.dart';

class loginScreen extends StatelessWidget {
  
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  var loginformkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     
      return BlocConsumer<Logincubit,socialStates>(
           listener: (context,state){
             var cubit=Logincubit.get(context);
                if(state is Errorloginstate)
                {  toast(
                      text: state.error,
                      state: toastStates.Error);
                }
                if(state is Successloginstate)
                {
                  NavigatorAndFinish(context,layout_screen());
                }
           },
          builder: (context,state){
            var cubit=Logincubit.get(context);
          return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: loginformkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black),
                        ),
                       Text('Login now to communication with your friends',
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 20,),
                      defultTextField(
                        context: context,
                         vaildate: (value)
                         {
                           if(value!.isEmpty){
                             return'Email Addreas must not be empty';
                           }
                         },
                         type: TextInputType.emailAddress,
                         labal: 'Email',
                         prefix: Icons.email_outlined,
                         controller: emailcontroller,
                         ),
                      SizedBox(height: 20,),
                      defultTextField(
                        context: context,
                         vaildate: (value)
                         {
                           if(value!.isEmpty){
                             return'Password must not be empty';
                           }
                         },
                         type: TextInputType.visiblePassword,
                         labal: 'Password',
                         prefix: Icons.lock_open,
                         ispassword: cubit.ispassword,
                         controller: passwordcontroller,
                         suffix: cubit.icon,
                         suffixpressed: (){
                           cubit.changeVisibilty();
                         },
                         onsubmit: (value){
                           if(loginformkey.currentState!.validate()){

                           }
                         }
                         ),
                      SizedBox(height: 20,),
                      BuildCondition(
                        condition:state is !Loadingloginstate ,
                        builder: (context)=>defultButton(text: 'LOGIN',
                         ontap: (){
                           if(loginformkey.currentState!.validate())
                           {
                              cubit.UserLogin(
                               email: emailcontroller.text,
                               password: passwordcontroller.text);
                           }
                         }
                         ),
                        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account',
                          style:TextStyle(fontSize: 16) ,),
                          SizedBox(width: 10,),
                          defultTextButton(
                            text: 'Requester',
                            ontap: (){
                              NavigatorAndFinish(context, register_screen());
                            }),
                           ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          );

          },
          );



  }
}