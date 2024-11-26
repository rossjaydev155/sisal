// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// Definizione degli stati
enum InstagramState { initial, loading, success, failure }

class InstagramCubit extends Cubit<InstagramState> {
  InstagramCubit() : super(InstagramState.initial);

  Future<void> openInstagram() async {
    emit(InstagramState.loading); // Stato di caricamento

    const appUrl = 'instagram://app';
    const storeUrl = 'https://play.google.com/store/apps/details?id=com.instagram.android';

    try {
      if (await canLaunchUrl(Uri.parse(appUrl))) {
        await launchUrl(Uri.parse(appUrl));
        emit(InstagramState.success); // Successo
      } else {
        await launchUrl(Uri.parse(storeUrl), mode: LaunchMode.externalApplication);
        emit(InstagramState.success); // Successo (ha aperto lo store)
      }
    } catch (e) {
      emit(InstagramState.failure); // Fallimento
    }
  }
}
