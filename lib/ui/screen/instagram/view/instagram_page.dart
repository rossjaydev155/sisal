import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisal/common/l10n/l10n.dart';
import 'package:sisal/ui/screen/instagram/cubit/instagram_cubit.dart';

class InstagramScreen extends StatelessWidget {
  const InstagramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.instagramAppBarTitle)),
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
