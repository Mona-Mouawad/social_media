import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/cubit/states.dart';
import 'package:social_media/model/userModel.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/helper/cach_Helper.dart';

class Registercubit extends Cubit<socialStates>{

  Registercubit() : super(socialinitialState());
  static Registercubit get(context)=>BlocProvider.of(context);
  
  
 IconData icon=Icons.visibility_outlined;
 bool ispassword =true;
  
  void changeVisibilty()
  {
    ispassword=!ispassword;
    icon=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeVisibilityloginstate());
  }

  void CreateUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    UserModel usermodel =UserModel(
      email: email,
      uId: uId,
      name: name,
      phone: phone,
      token: token,
      image: 'https://cdn-icons-png.flaticon.com/512/21/21104.png',
      bio: 'bio...',
      coverimage: 'https://image.freepik.com/free-vector/gradient-pastel-sky-background_23-2148896311.jpg',
      isEmailVerified: false,
      );

    FirebaseFirestore.instance.collection('user')
    .doc(uId)
    .set(usermodel.toMap()).then((value){
       emit(SuccessCreateUserState());
    }).catchError((error){
      print('  error___2  '+error.toString());
      emit(ErrorCreateUserState(error));
    });

  }
  
  
  void Register({
    required String email,
    required String password,
    required String phone,
    required String name
  })
  {
    emit(LoadingRegisterState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password).
    then((value) {
      print(value.user!.uid.toString());
      Cach_helper.SaveData(key: 'uId', value: value.user!.uid);
      CreateUser(phone: phone,
      name: name,
      email: email,
      uId: value.user!.uid
      );
      uid=value.user!.uid;
    }).catchError((error){
      print(error.toString());
      emit(ErrorRegisterState('  error__1  '+error.toString()));
    });
    
  }
  }
