import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisal/cubits/feed_cubit/feed_cubit.dart';
import 'package:sisal/repositories/feed_repository.dart';
import 'package:sisal/app/view/app.dart';

Future<void> bootstrap(Future<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Aggiungi qui qualsiasi inizializzazione necessaria, come i plugin o Firebase

  // Crea i provider richiesti
  final feedRepository = FeedRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FeedRepository>.value(value: feedRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FeedCubit>(
            create: (context) => FeedCubit(feedRepository),
          ),
        ],
        child: await builder(),
      ),
    ),
  );
}

void main() {
  bootstrap(() async => const App());
}
