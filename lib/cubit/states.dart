abstract class socialStates{}

class socialinitialState extends socialStates{}

class Loadingloginstate  extends socialStates{}

class Successloginstate extends socialStates{}

class Errorloginstate extends socialStates{
  final String error;
  Errorloginstate(this.error);
}
class ChangeVisibilityloginstate extends socialStates{}

class ChangeBottomstate extends socialStates{}

class ChangeIndicatorState extends socialStates{}

class LoadingRegisterState  extends socialStates{}

class SuccessRegisterState extends socialStates{}

class ErrorRegisterState extends socialStates{
  final String error;
  ErrorRegisterState(this.error);
}

class LoadingSendVerificationMailState  extends socialStates{}

class SuccessSendVerificationMailState extends socialStates{}

class ErrorSendVerificationMailState extends socialStates{
  final String error;
  ErrorSendVerificationMailState(this.error);
}

class LoadingReloadVerificationMailState  extends socialStates{}

class SuccessReloadVerificationMailState extends socialStates{}

class ErrorReloadVerificationMailState extends socialStates{
  final String error;
  ErrorReloadVerificationMailState(this.error);
}

class LoadingCreateUserState  extends socialStates{}

class SuccessCreateUserState extends socialStates{}

class ErrorCreateUserState extends socialStates{
  final String error;
  ErrorCreateUserState(this.error);
}

class LoadingGetUserState  extends socialStates{}

class SuccessGetUserState extends socialStates{}

class ErrorGetUserState extends socialStates{
  final String error;
  ErrorGetUserState(this.error);
}

class LoadingGetAllUserState  extends socialStates{}

class SuccessGetAllUserState extends socialStates{}

class ErrorGetAllUserState extends socialStates{
  final String error;
  ErrorGetAllUserState(this.error);
}

class LoadingUpdateUserState  extends socialStates{}

class LoadingUpdateprofileUserState  extends socialStates{}
class LoadingUpdatecoverUserState  extends socialStates{}


class SuccessUpdateUserState extends socialStates{}

class ErrorUpdateUserState extends socialStates{
  final String error;
  ErrorUpdateUserState(this.error);
}

class SuccessGetImageprofileState extends socialStates{}

class ErrorGetImageprofileState extends socialStates{}


class SuccessGetImageCoverState extends socialStates{}

class ErrorGetImageCoverState extends socialStates{}

class SuccessUploadImageprofileState extends socialStates{}

class ErrorUploadImageprofiState extends socialStates{
  final String error;
  ErrorUploadImageprofiState(this.error);
}

class SuccessUploadImageCoverState extends socialStates{}

class ErrorUploadImageCoverState extends socialStates{
  final String error;
  ErrorUploadImageCoverState(this.error);
}

class SuccessSentMassageState extends socialStates{}

class ErrorSentMassageState extends socialStates{
  final String error;
  ErrorSentMassageState(this.error);
}

class LoadingCreatPostState extends socialStates{}

class SuccessGettMassageState extends socialStates{}

class SuccessCreatPostState extends socialStates{}

class ErrorCreatPostState extends socialStates{
  final String error;
  ErrorCreatPostState(this.error);
}

class SuccessGetPostImagerState extends socialStates{}

class ErrorGetPostIImagerState extends socialStates{}

class SuccessUploadPostIImageState extends socialStates{}

class ErrorUploadPostIImageState extends socialStates{
  final String error;
  ErrorUploadPostIImageState(this.error);
}

class LoadingGetPostState extends socialStates{}

class SuccessGetPostState extends socialStates{}

class ErrorGetPostState extends socialStates{
  final String error;
  ErrorGetPostState(this.error);
}

class SuccessUpdataPost_userDataState extends socialStates{}

class ErrorUpdataPost_userDataState extends socialStates{
  final String error;
  ErrorUpdataPost_userDataState(this.error);
}

class SuccessRemovePostImageState extends socialStates{}

class SuccessLikePostState extends socialStates{}

class ErrorLikePostState extends socialStates{
  final String error;
  ErrorLikePostState(this.error);
}

class SuccessCommentPostState extends socialStates{}

class ErrorCommentPostState extends socialStates{
  final String error;
  ErrorCommentPostState(this.error);
}

class SuccessGetCommentPostState extends socialStates{}

class ErrorGetCommentPostState extends socialStates{
  final String error;
  ErrorGetCommentPostState(this.error);
}

class SuccessGetCommentNumState extends socialStates{}

class ErrorGetCommentNumState extends socialStates{
  final String error;
  ErrorGetCommentNumState(this.error);
}

class SuccessGetLikeNumState extends socialStates{}

class ErrorGetLikeNumState extends socialStates{
  final String error;
  ErrorGetLikeNumState(this.error);
}

class SuccessUNLikeState extends socialStates{}

class ErrorUNLikeState extends socialStates{
  final String error;
  ErrorUNLikeState(this.error);
}

class SuccessDeletCommentState extends socialStates{}

class ErrorDeletCommentState extends socialStates{
  final String error;
  ErrorDeletCommentState(this.error);
}

class SuccessDeletPosttState extends socialStates{}

class ErrorDeletPosttState extends socialStates{
  final String error;
  ErrorDeletPosttState(this.error);
}

class SuccessSendNotifications extends socialStates{}

class ErrorSendNotifications extends socialStates{
  ErrorSendNotifications();
}

class SuccessGetNotifications extends socialStates{}

class LoadingGetSinglePostState extends socialStates{}

class SuccessGetSinglePostState extends socialStates{}

class SuccessGetPosts_userData extends socialStates{}

class ErrorGetPosts_userData extends socialStates{
  final String error;
  ErrorGetPosts_userData(this.error);
}