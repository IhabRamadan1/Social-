abstract class AppStates{}
class soInitia extends AppStates{}
class soLoading extends AppStates{}
class soSuccess extends AppStates{}
class soError extends AppStates{
  final String error;

  soError(this.error);

}
class soChangeButton extends AppStates{}
class AddPostState extends AppStates{}
class successProfileState extends AppStates{}
class errorProfileState extends AppStates{}

class successCoverState extends AppStates{}
class errorCoverState extends AppStates{}

class successuploadProfileState extends AppStates{}
class erroruploadProfileState extends AppStates{}

class successuploadCoverState extends AppStates{}
class erroruploadCoverState extends AppStates{}

class loadingUpdateState extends AppStates{}
class successUpdateState extends AppStates{}
class errorUpdateState extends AppStates{}

class loadingPostImageState extends AppStates{}
class successPostImageState extends AppStates{}
class errorPostImageState extends AppStates{}

class loadingCreatePostState extends AppStates{}
class successCreatePostState extends AppStates{}
class errorCreatePostState extends AppStates{}

class removePostImageState extends AppStates{}

class loadinggetAllPostState extends AppStates{}
class successgetAllPostState extends AppStates{}
class errorgetAllPostState extends AppStates{}

class successLikeState extends AppStates{}
class errorLikeState extends AppStates{}

class successCommentState extends AppStates{}
class errorCommentState extends AppStates{}

class loadinggetAllUsersState extends AppStates{}
class successgetAllUsersState extends AppStates{}
class errorgetAllUsersState extends AppStates{}

class successSendMessagesState extends AppStates{}
class errorSendMessagesState extends AppStates{}
class successGetMessagesState extends AppStates{}
class errorGetMessagesState extends AppStates{}

class loadingSetCommentState extends AppStates{}
class successSetCommentState extends AppStates{}
class errorSetCommentState extends AppStates{}

class loadingWriteCommentState extends AppStates{}
class successWriteCommentState extends AppStates{}
class errorWriteCommentState extends AppStates{}








