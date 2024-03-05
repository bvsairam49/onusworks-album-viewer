import 'package:bloc/bloc.dart';
import 'package:onusworks_albums_app/service/database/user_database.dart';
import 'package:onusworks_albums_app/src/onboard/state/onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  final UserDatabase userDatabase = UserDatabase();

  OnboardCubit() : super(InitialOnboardState());

  void saveCredentials(String username, String password) async {
    try {
      await userDatabase.storeUserCredentials(username, password);
      emit(SuccessfulSaveState()); // Emit state to indicate successful saving
    } catch (e) {
      emit(ErrorState(
          errorMessage: e
              .toString())); // Emit state to indicate failure with error message
    }
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await userDatabase.isLoggedIn();
    return isLoggedIn;
  }

  Future<bool> isUserCompletedOnboarding() async {
    bool isUserCompletedOnboarding =
        await userDatabase.isUserCompletedOnboarding();
    return isUserCompletedOnboarding;
  }
}
