abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginAuthenticated extends LoginState {}
