// ignore_for_file: avoid_slow_async_io

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PhotoRepository {
  Future<String> getPhotoPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/saved_photo.jpg';
  }

  Future<File> savePhoto(File photo) async {
    final path = await getPhotoPath();
    return photo.copy(path);
  }

  Future<File?> loadSavedPhoto() async {
    final path = await getPhotoPath();
    final file = File(path);
    if (await file.exists()) {
      return file;
    }
    return null;
  }
}
