import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:sisal/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sisal/common/constants.dart';

// Definizione degli stati
enum InstagramState { initial, loading, success, failure }

class InstagramCubit extends Cubit<InstagramState> {
  InstagramCubit() : super(InstagramState.initial);

  Future<void> openInstagram() async {
    emit(InstagramState.loading); // Stato di caricamento

    // URL per Android e iOS
    final androidAppUrl = Constants.androidAppUrl;
    final iosAppUrl = Constants.iosAppUrl;
    final storeUrl = Constants.storeUrl;
    final iosStoreUrl = Constants.iosStoreUrl;

    try {
      if (io.Platform.isAndroid) {
        // Android
        if (await canLaunchUrl(Uri.parse(androidAppUrl))) {
          await launchUrl(Uri.parse(androidAppUrl));
          emit(InstagramState.success); // Successo
        } else {
          await launchUrl(Uri.parse(storeUrl),
              mode: LaunchMode.externalApplication);
          emit(InstagramState.success); // Successo (ha aperto lo store)
        }
      } else if (io.Platform.isIOS) {
        // iOS
        if (await canLaunchUrl(Uri.parse(iosAppUrl))) {
          await launchUrl(Uri.parse(iosAppUrl));
          emit(InstagramState.success); // Successo
        } else {
          await launchUrl(Uri.parse(iosStoreUrl),
              mode: LaunchMode.externalApplication);
          emit(InstagramState.success); // Successo (ha aperto lo store)
        }
      }
    } catch (e) {
      emit(InstagramState.failure); // Fallimento
    }
  }
}
