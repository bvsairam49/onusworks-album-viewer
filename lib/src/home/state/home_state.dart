import 'package:onusworks_albums_app/src/data/album_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Album> albums;

  HomeLoaded(this.albums);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeDeleted extends HomeState {
  final List<Album> albums;

  HomeDeleted(this.albums);
}
