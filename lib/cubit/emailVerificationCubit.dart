import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/cubit/states.dart';

class EmailVerificationCubit extends Cubit<socialStates>{
  EmailVerificationCubit() : super(socialinitialState());

  static EmailVerificationCubit get(context) => BlocProvider.of(context);

  // send email verification
  bool isEmailSent = false ;
  void sendEmailVerification(){
    emit(LoadingSendVerificationMailState());
    FirebaseAuth.instance.currentUser!.sendEmailVerification()
        .then((value){
      isEmailSent = true ;
      emit(SuccessSendVerificationMailState());
    })
        .catchError((error){
      emit(ErrorSendVerificationMailState(error.toString()));
    })
    ;
  }

// reload user
  bool isEmailVerified = false;
  Future<void> reloadUser() async {
    emit(LoadingReloadVerificationMailState());
    await FirebaseAuth.instance.currentUser!.reload()
        .then((value){
      if (FirebaseAuth.instance.currentUser!.emailVerified)
      {
        isEmailVerified = true;

      }

      emit(SuccessReloadVerificationMailState());
    })
        .catchError((error){
      emit(ErrorReloadVerificationMailState(error.toString()));
    });
  }


}