import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/service/api_service/api_service.dart';
import 'package:onusworks_albums_app/src/album_photos/state/album_photos_state.dart';

class AlbumPhotosCubit extends Cubit<AlbumPhotosState> {
  AlbumPhotosCubit() : super(AlbumPhotosInitial());
  final ApiService _apiService = ApiService();
  Future<void> fetchPhotos(int albumId) async {
    try {
      emit(AlbumPhotosLoading());
      var photoList = await _apiService.fetchPhotos(albumId);
      emit(AlbumPhotosLoaded(photoList));
    } catch (e) {
      emit(AlbumPhotosError('Failed to fetch photos'));
    }
  }
}
