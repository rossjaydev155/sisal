import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' as io;

// Definizione degli stati
enum InstagramState { initial, loading, success, failure }

class InstagramCubit extends Cubit<InstagramState> {
  InstagramCubit() : super(InstagramState.initial);

  Future<void> openInstagram() async {
    emit(InstagramState.loading); // Stato di caricamento

    // URL per Android e iOS
    const androidAppUrl = 'instagram://app';
    const iosAppUrl = 'instagram://app';
    const storeUrl = 'https://play.google.com/store/apps/details?id=com.instagram.android';
    const iosStoreUrl = 'https://apps.apple.com/app/instagram/id389801252';

    try {
      if (io.Platform.isAndroid) {
        // Android
        if (await canLaunchUrl(Uri.parse(androidAppUrl))) {
          await launchUrl(Uri.parse(androidAppUrl));
          emit(InstagramState.success); // Successo
        } else {
          await launchUrl(Uri.parse(storeUrl), mode: LaunchMode.externalApplication);
          emit(InstagramState.success); // Successo (ha aperto lo store)
        }
      } else if (io.Platform.isIOS) {
        // iOS
        if (await canLaunchUrl(Uri.parse(iosAppUrl))) {
          await launchUrl(Uri.parse(iosAppUrl));
          emit(InstagramState.success); // Successo
        } else {
          await launchUrl(Uri.parse(iosStoreUrl), mode: LaunchMode.externalApplication);
          emit(InstagramState.success); // Successo (ha aperto lo store)
        }
      }
    } catch (e) {
      emit(InstagramState.failure); // Fallimento
    }
  }
}
