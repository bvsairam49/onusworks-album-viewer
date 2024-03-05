import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class Album {
  final int userId;
  final int id;
  final String title;
  bool isFavorite = false;

  Album(this.userId, this.id, this.title, {this.isFavorite = false});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
