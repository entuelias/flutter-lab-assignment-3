import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/album_viewmodel.dart';
import '../models/album.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<AlbumViewModel, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading albums...'),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            if (state.albums.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_album_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('No albums found'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => context.read<AlbumViewModel>().add(LoadAlbums()),
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AlbumViewModel>().add(LoadAlbums());
              },
              child: ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  final photos = state.albumPhotos[album.id] ?? [];
                  final firstPhoto = photos.isNotEmpty ? photos.first : null;
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: firstPhoto != null
                            ? Image.network(
                                firstPhoto.thumbnailUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.primaries[index % Colors.primaries.length].shade200,
                                    child: const Icon(Icons.photo, color: Colors.white),
                                  );
                                },
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                color: Colors.primaries[index % Colors.primaries.length].shade200,
                                child: const Icon(Icons.photo, color: Colors.white),
                              ),
                      ),
                      title: Text(album.title),
                      subtitle: Text('${photos.length} photos'),
                      onTap: () => context.go('/album/${album.id}'),
                    ),
                  );
                },
              ),
            );
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AlbumViewModel>().add(LoadAlbums());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}