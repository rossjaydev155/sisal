// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisal/domain/repositories/feed_repository.dart';
import 'package:sisal/domain/repositories/photo_repository.dart';
import 'package:sisal/ui/screen/feed/cubit/feed_cubit.dart';
import 'package:sisal/ui/screen/instagram/cubit/instagram_cubit.dart';
import 'package:sisal/ui/screen/photo/cubit/photo_cubit.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(Future<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

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
          BlocProvider<InstagramCubit>(create: (_) => InstagramCubit()),
          BlocProvider<PhotoCubit>(
              create: (context) =>
                  PhotoCubit(context as PhotoRepository),), // InstagramCubit
        ],
        child: await builder(),
      ),
    ),
  );
}
