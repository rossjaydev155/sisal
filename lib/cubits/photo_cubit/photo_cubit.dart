import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../repositories/photo_repository.dart';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final File photo;

  PhotoLoaded(this.photo);
}

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository repository;

  PhotoCubit(this.repository) : super(PhotoInitial());

  Future<void> loadPhoto() async {
    emit(PhotoLoading());
    final photo = await repository.loadSavedPhoto();
    if (photo != null) {
      emit(PhotoLoaded(photo));
    } else {
      emit(PhotoInitial());
    }
  }

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final photo = File(pickedFile.path);
      await repository.savePhoto(photo);
      emit(PhotoLoaded(photo));
    }
  }

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final photo = File(pickedFile.path);
      await repository.savePhoto(photo);
      emit(PhotoLoaded(photo));
    }
  }
}
