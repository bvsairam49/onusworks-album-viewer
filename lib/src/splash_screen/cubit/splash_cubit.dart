import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/service/database/user_database.dart';
import 'package:onusworks_albums_app/src/splash_screen/state/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  final UserDatabase _userDatabase = UserDatabase();

  void isLoggedIn() async {
    emit(SplashLoading());
    bool isLoggedIn = await _userDatabase.isLoggedIn();
    emit(SplashLoggedInLoaded(isLoggedIn));
  }

  void isOnboarded() async {
    emit(SplashLoading());
    bool isOnboarded = await _userDatabase.isUserCompletedOnboarding();
    bool isLoggedIn = await _userDatabase.isLoggedIn();
    if (isLoggedIn) {
      emit(SplashLoggedInLoaded(isLoggedIn));
      return;
    }
    emit(SplashOnboardedLoaded(isOnboarded));
  }
}
