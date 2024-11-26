import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/instagram_cubit/instagram_cubit.dart';

class InstagramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apri Instagram')),
      body: BlocProvider(
        create: (_) => InstagramCubit(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Clicca il pulsante per aprire Instagram.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.read<InstagramCubit>().openInstagram(),
                child: const Text('Apri Instagram'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
