
abstract class SocialRegistrationStates{}

class SocialRegistrationInitialState extends SocialRegistrationStates{}

class SocialRegistrationLoadingState extends SocialRegistrationStates {}

class SocialRegistrationSuccessState extends SocialRegistrationStates {}

class SocialRegistrationErrorState extends SocialRegistrationStates
{
  final String error;

  SocialRegistrationErrorState(this.error);
}

class SocialCreateUserLoadingState extends SocialRegistrationStates {}

class SocialCreateUserSuccessState extends SocialRegistrationStates {}

class SocialCreateUserErrorState extends SocialRegistrationStates
{
  final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialRegistrationStates {}
