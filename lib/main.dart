import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'data/album_api_service.dart';
import 'viewmodels/album_viewmodel.dart';
import 'screens/album_list_screen.dart';
import 'screens/album_detail_screen.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (_) => AlbumApiService(httpClient: http.Client()),
      child: BlocProvider(
        create: (context) => AlbumViewModel(
          apiService: context.read<AlbumApiService>(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AlbumListScreen(),
        ),
        GoRoute(
          path: '/album/:id',
          builder: (context, state) {
            final albumId = int.parse(state.pathParameters['id']!);
            return AlbumDetailScreen(albumId: albumId);
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: ${state.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );

    return MaterialApp.router(
      title: 'Flutter Album App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
