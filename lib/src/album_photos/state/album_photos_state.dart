import 'package:onusworks_albums_app/src/data/photo_model.dart';

abstract class AlbumPhotosState {}

class AlbumPhotosInitial extends AlbumPhotosState {}

class AlbumPhotosLoading extends AlbumPhotosState {}

class AlbumPhotosLoaded extends AlbumPhotosState {
  final List<Photo> photos;
  AlbumPhotosLoaded(this.photos);
}

class AlbumPhotosError extends AlbumPhotosState {
  final String error;
  AlbumPhotosError(this.error);
}