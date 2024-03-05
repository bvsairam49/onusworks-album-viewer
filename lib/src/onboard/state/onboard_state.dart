abstract class OnboardState {}

class InitialOnboardState extends OnboardState {}

class SuccessfulSaveState extends OnboardState {}

class LoadingState extends OnboardState {}

class ErrorState extends OnboardState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
