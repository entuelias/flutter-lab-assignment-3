import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../data/album_api_service.dart';

// Events
abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
  @override
  List<Object?> get props => [];
}

class LoadAlbums extends AlbumEvent {}

// States
abstract class AlbumState extends Equatable {
  const AlbumState();
  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}
class AlbumLoading extends AlbumState {}
class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final Map<int, List<Photo>> albumPhotos;
  const AlbumLoaded({required this.albums, required this.albumPhotos});
  @override
  List<Object?> get props => [albums, albumPhotos];
}
class AlbumError extends AlbumState {
  final String message;
  const AlbumError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc/ViewModel
class AlbumViewModel extends Bloc<AlbumEvent, AlbumState> {
  final AlbumApiService apiService;
  
  // Cache for albums and photos
  List<Album>? _cachedAlbums;
  Map<int, List<Photo>>? _cachedPhotos;
  
  AlbumViewModel({required this.apiService}) : super(AlbumInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
    add(LoadAlbums());
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    try {
      emit(AlbumLoading());

      final albums = await apiService.fetchAlbums();
      final allPhotos = await apiService.fetchAllPhotos(); // Fetch all at once

      // Group photos by albumId
      final Map<int, List<Photo>> albumPhotos = {};
      for (final photo in allPhotos) {
        albumPhotos.putIfAbsent(photo.albumId, () => []).add(photo);
      }

      _cachedAlbums = albums;
      _cachedPhotos = albumPhotos;

      emit(AlbumLoaded(albums: albums, albumPhotos: albumPhotos));
    } catch (e) {
      print('Error loading albums: $e');
      emit(AlbumError(e.toString()));
    }
  }

  void clearCache() {
    _cachedAlbums = null;
    _cachedPhotos = null;
  }
} 