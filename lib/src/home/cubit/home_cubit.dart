import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/service/api_service/api_service.dart';
import 'package:onusworks_albums_app/service/database/user_database.dart';
import 'package:onusworks_albums_app/src/data/album_model.dart';
import 'package:onusworks_albums_app/src/home/state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService = ApiService();
  final UserDatabase _userDatabase = UserDatabase();

  HomeCubit() : super(HomeInitial());

  // To fetch the albums
  Future<void> fetchAlbums() async {
    //Set loading state
    emit(HomeLoading());
    try {
      List<Album> albums = await _apiService.fetchAlbums();
      // Set loaded state
      emit(HomeLoaded(albums));
    } catch (e) {
      emit(HomeError('Failed to fetch albums'));
    }
  }

  Future<void> deleteAlbum(int albumId, List<Album> albums) async {
    emit(HomeLoading());
    try {
      bool isDeleted = await _apiService.deleteAlbum(albumId);
      if (isDeleted) {
        albums.removeWhere((element) => element.id == albumId);
        emit(HomeDeleted(albums));
      }
      emit(HomeDeleted(albums));
    } catch (e) {
      emit(HomeError('Failed to delete album'));
    }
  }

  Future<bool> addNewAlbum(String albumTitle, String id) async {
    try {
      bool isNewAlbumAdded = await _apiService.addNewAlbum(
        id,
        albumTitle,
      );
      return isNewAlbumAdded;
    } catch (e) {
      return false;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _userDatabase.setUsersLogout();
    } catch (e) {
      emit(HomeError('Something went wrong'));
    }
  }
}
