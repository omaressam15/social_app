
abstract class StatesHome {}

class HomeInitialState extends StatesHome{}

class HomeSuccessState extends StatesHome{}

class HomeLoadingState extends StatesHome{}

class  ScreenNewPost extends StatesHome{}

class ChangeButtonNavigationBar extends StatesHome{}

class PickerProfileImageSuccess extends StatesHome{}

class PickerProfileImageError extends StatesHome{}

class PickerCoverImageSuccess extends StatesHome{}

class PickerCoverImageError extends StatesHome{}

class PickerPostImageSuccess extends StatesHome{}

class PickerPostImageError extends StatesHome{}

class UploadCoverImageSuccess extends StatesHome{}

class UploadCoverImageError extends StatesHome{}

class UploadPostImageSuccess extends StatesHome{}

class CreatePostsSusses extends StatesHome{}

class CreatePostsError extends StatesHome{}

class CreateLikePostSusses extends StatesHome{}

class CreateLikePostError extends StatesHome{}

class CreateCommentPostSusses extends StatesHome{}

class CreateCommentPostError extends StatesHome{}

class GetCommentPostSusses extends StatesHome{}

class GetCommentPostError extends StatesHome{}

class RemovePostImage extends StatesHome{}

class UploadProfileImageSuccess extends StatesHome{}

class UploadProfileImageError extends StatesHome{}

class UserUpdateDataSuccess extends StatesHome{}

class UserUpdateDataError extends StatesHome{}

class LoadingUpdateUserData extends StatesHome{}

class LoadingCreatePost extends StatesHome{}

class LoadingUpdateProfileImage extends StatesHome{}

class LoadingUpdateCoverImage extends StatesHome{}

class LoadingGetPost extends StatesHome{}

class GetPostSuccess extends StatesHome{}

class GetUserDataSuccess extends StatesHome{}
class GetUserDataError extends StatesHome{}

class ErrorGetPost extends StatesHome{
  final String error;

  ErrorGetPost(this.error);
}

class HomeErrorState extends StatesHome{
  final String error;
  HomeErrorState(this.error);
}