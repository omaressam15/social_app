
abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates {}

class ChangeVisibility extends SocialLoginStates{}
class LoadingUpdateDeviceTokenError extends SocialLoginStates{}

class GetUsersData extends SocialLoginStates{}
class LoadingUsersData extends SocialLoginStates{}
class GetUsersDataError extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates {

  final String uid;

  SocialLoginSuccessState(this.uid);

}

class SocialLoginErrorState extends SocialLoginStates {

  final String error;

  SocialLoginErrorState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates {}
