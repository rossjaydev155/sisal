// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisal/common/l10n/l10n.dart';
import 'package:sisal/domain/repositories/photo_repository.dart';
import 'package:sisal/ui/screen/photo/cubit/photo_cubit.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.photoAppBarTitle)),
      body: BlocProvider(
        create: (_) => PhotoCubit(PhotoRepository())..loadPhoto(),
        child: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (state is PhotoLoading) ...[
                    const CircularProgressIndicator(),
                  ] else if (state is PhotoLoaded) ...[
                    Image.file(state.photo, height: 300, width: double.infinity, fit: BoxFit.cover),
                  ] else ...[
                    const Text('Nessuna foto selezionata.', style: TextStyle(fontSize: 16)),
                  ],
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => context.read<PhotoCubit>().pickPhoto(),
                    child: const Text('Carica dalla Galleria'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.read<PhotoCubit>().takePhoto(),
                    child: const Text('Scatta una Foto'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
