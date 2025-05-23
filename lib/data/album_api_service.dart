import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

/// Data Layer: Handles API calls for albums and photos
class AlbumApiService {
  final http.Client httpClient;
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  AlbumApiService({required this.httpClient});

  /// Fetch all albums
  Future<List<Album>> fetchAlbums() async {
    try {
      final response = await httpClient.get(Uri.parse('$_baseUrl/albums'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load albums: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  /// Fetch all photos at once
  Future<List<Photo>> fetchAllPhotos() async {
    try {
      final response = await httpClient.get(Uri.parse('$_baseUrl/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }

  /// Fetch photos for a specific album
  Future<List<Photo>> fetchPhotosByAlbumId(int albumId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$_baseUrl/photos?albumId=$albumId'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos for album $albumId: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load photos for album $albumId: $e');
    }
  }

  void dispose() {
    httpClient.close();
  }
} 