// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisal/cubits/feed_cubit/feed_cubit.dart';
import 'package:sisal/cubits/feed_cubit/feed_state.dart';
import 'package:sisal/widgets/webview_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed RSS')),
      body: BlocProvider(
        create: (context) => FeedCubit(RepositoryProvider.of(context))..fetchFeed(),
        child: BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state) {
            if (state is FeedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FeedLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    leading: Image.network(item.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item.description.length > 50
                        ? item.description.substring(0, 50) + '...'
                        : item.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(url: item.link),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is FeedError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Inizia il caricamento...'));
            }
          },
        ),
      ),
    );
  }
}
