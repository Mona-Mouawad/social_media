import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/RegisterCubit.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/modules/Login.dart';
import 'package:social_media/shared/component.dart';
import 'emailVerification.dart';

class register_screen extends StatelessWidget {
  
  var registerKey =GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<Registercubit,socialStates>(
           builder: (context,state){
              var cubit=Registercubit.get(context);
              return Scaffold(
          appBar: AppBar(),
           body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: registerKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.black),
                          ),
                         Text('Register now to communication with your friends',
                        style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 20,),
                        defultTextField(
                          context: context,
                           vaildate: (value)
                           {
                             if(value!.isEmpty){
                               return'Please enter your Name';
                             }
                           },
                           type: TextInputType.name,
                           labal: 'Name',
                           prefix: Icons.person,
                           controller: namecontroller,
                           ),
                        SizedBox(height: 20,),
                        defultTextField(
                          context: context,
                           vaildate: (value)
                           {
                             if(value!.isEmpty){
                               return'Please enter your Email Addreas ';
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
                               return'Please enter your Password';
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

                           ),
                        SizedBox(height: 20,),
                        defultTextField(
                          context: context,
                           vaildate: (value)
                           {
                             if(value!.isEmpty){
                               return'Please enter your Phone';
                             }
                           },
                           type: TextInputType.phone,
                           labal: 'Phone',
                           prefix: Icons.phone,
                           //ispassword: true,
                           controller: phonecontroller,

                           ),
                        SizedBox(height: 20,),
                        BuildCondition(
                          condition: state is ! LoadingRegisterState,
                          builder: (context)=>defultButton(text: 'Register',
                           ontap: (){
                             if(registerKey.currentState!.validate())
                             {
                                cubit.Register(
                                 name: namecontroller.text,
                                 phone: phonecontroller.text,
                                 email: emailcontroller.text,
                                 password: passwordcontroller.text, );
                             }
                           }),
                           fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),
                         SizedBox(height: 35,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",style: TextStyle(fontSize: 17),),
                          defultTextButton(text: "Log In", ontap: ()=>NavigatorTo(context, loginScreen()))
                         ,
                        ],
                      ),
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
        },
           listener: (context,state){
                 var cubit=Registercubit.get(context);
                if(state is ErrorRegisterState)
                {  toast(
                      text: state.error,
                      state: toastStates.Error);
                }
                  if(state is SuccessCreateUserState)
                {
                  NavigatorAndFinish(context, EmailVerificationScreen());
                }
           },



    );
  }
}