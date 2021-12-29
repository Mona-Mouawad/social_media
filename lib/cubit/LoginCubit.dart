import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/helper/cach_Helper.dart';

class Logincubit extends Cubit<socialStates>{

  Logincubit() : super(socialinitialState());
  static Logincubit get(context)=>BlocProvider.of(context);
  
  
 IconData icon=Icons.visibility_outlined;
 bool ispassword =true;
  
  void changeVisibilty()
  {
    ispassword=!ispassword;
    icon=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeVisibilityloginstate());
  }
  
  
  void UserLogin({
    required String email,
    required String password,
  })
  {
    emit(Loadingloginstate());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value) {
      print(value.user!.uid.toString());
      Cach_helper.SaveData(key: 'uId', value: value.user!.uid);
      uid=value.user!.uid;
      emit(Successloginstate());
    }).catchError((error){
      emit(Errorloginstate(error.toString()));
    });
    
  }
}