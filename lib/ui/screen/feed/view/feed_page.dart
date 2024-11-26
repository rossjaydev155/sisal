// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' show parse;
import 'package:sisal/common/l10n/l10n.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit/feed_state.dart';
import 'package:sisal/ui/widgets/webview_screen.dart';

String decodeHtml(String html) {
  final document = parse(html);
  return document.body?.text ?? '';
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.feedRSSAppBarTitle)),
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
                  return Column(
                  children: [
                    ListTile(
                      leading: Image.network(item.thumbnail, width: 80, height: 120, fit: BoxFit.fitHeight),
                      title: Text(decodeHtml(item.title),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      subtitle: Text(decodeHtml(item.description.length > 50
                                ? item.description.substring(0, 50) + '...'
                                : item.description,), style: const TextStyle(fontSize: 14),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(url: item.link),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                  ],
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
