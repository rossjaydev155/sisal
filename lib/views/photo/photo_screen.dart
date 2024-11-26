// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisal/cubits/photo_cubit/photo_cubit.dart';
import 'package:sisal/repositories/photo_repository.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aggiungi una Foto')),
      body: BlocProvider(
        create: (_) => PhotoCubit(PhotoRepository())..loadPhoto(),
        child: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
