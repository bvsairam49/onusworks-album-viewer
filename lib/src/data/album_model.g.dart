// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'isFavorite': instance.isFavorite,
    };
