import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/service/database/user_database.dart';
import 'package:onusworks_albums_app/src/login/state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserDatabase userDatabase = UserDatabase();
  LoginCubit() : super(LoginInitial());

  void authenticateUser(String username, String password) async {
    try {
      emit(LoginLoading());
      bool isLoggedIn =
          await userDatabase.checkUserCredentials(username, password);
      if (!isLoggedIn) {
        // Emit state to indicate invalid credentials
        emit(LoginError('Invalid username or password'));
        return;
      }
      // Set the user as logged in when the credentials are valid
      await userDatabase.setLoggedIn(username, true);
      // Emit state to indicate successful authentication

      emit(LoginAuthenticated());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
