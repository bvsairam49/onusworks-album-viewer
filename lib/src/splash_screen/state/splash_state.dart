abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoggedInLoaded extends SplashState {
  final bool isLoggedIn;
  SplashLoggedInLoaded(this.isLoggedIn);
}
class SplashOnboardedLoaded extends SplashState {
  final bool isOnboarded;
  SplashOnboardedLoaded(this.isOnboarded);
}
