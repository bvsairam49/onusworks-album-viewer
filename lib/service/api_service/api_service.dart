import 'package:dio/dio.dart';
import 'package:onusworks_albums_app/src/data/album_model.dart';
import 'package:onusworks_albums_app/src/data/photo_model.dart';

class ApiService {
  final Dio _dio = Dio();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> fetchAlbums() async {
    try {
      final response = await _dio.get('$baseUrl/albums');
      return (response.data as List).map((x) => Album.fromJson(x)).toList();
    } catch (e) {
      throw Exception('Failed to fetch albums');
    }
  }

  Future<bool> deleteAlbum(int albumId) async {
    try {
      final response = await _dio.delete('$baseUrl/albums/$albumId');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete album');
    }
  }

  Future<bool> addNewAlbum(String albumId, String title) async {
    try {
      final response = await _dio.post('$baseUrl/albums',
          data: {'id': albumId, 'userId': '1', 'title': title});
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to add as favorite');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
    try {
      final response = await _dio.get('$baseUrl/albums/$albumId/photos');
      return (response.data as List)
          .map((x) => Photo.fromJson(x))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch photos');
    }
  }
}
