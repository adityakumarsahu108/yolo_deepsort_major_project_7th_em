import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yolo_deepsort/bloc/media_event.dart';
import 'package:yolo_deepsort/bloc/media_state.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPickerBloc extends Bloc<MediaPickEvent, MediaPickState> {
  final ImagePicker _picker = ImagePicker();
  bool _isImageMode = true;

  MediaPickerBloc() : super(MediaPickerInitial()) {
    on<ToggleMediaModeEvent>(_onToggleMediaMode);
    on<PickImageEvent>(_onPickImage);
    on<PickVideoEvent>(_onPickVideo);
    on<MediaPickErrorEvent>(_onMediaPickError); // Handling the error event
  }

  void _onToggleMediaMode(
      ToggleMediaModeEvent event, Emitter<MediaPickState> emit) {
    _isImageMode = !_isImageMode;
    emit(MediaPickerModeChanged(isImageMode: _isImageMode));
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<MediaPickState> emit) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(MediaPickerImagePicked(File(pickedFile.path)));
        } else {
          emit(MediaPickerError(message: "No image selected."));
        }
      } catch (e) {
        emit(MediaPickerError(message: e.toString()));
      }
    } else {
      emit(MediaPickerError(message: "Permission to access gallery denied."));
    }
  }

  Future<void> _onPickVideo(
      PickVideoEvent event, Emitter<MediaPickState> emit) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
        if (pickedFile != null) {
         
          final file = File(pickedFile.path);
          if (await file.exists() && file.lengthSync() > 0) {
            emit(MediaPickerVideoPicked(file));
          } else {
            emit(MediaPickerError(message: "Invalid video file."));
          }
        } else {
          emit(MediaPickerError(message: "No video selected."));
        }
      } catch (e) {
        emit(MediaPickerError(message: "Error picking video: ${e.toString()}"));
      }
    } else {
      emit(MediaPickerError(message: "Permission to access gallery denied."));
    }
  }

  void _onMediaPickError(
      MediaPickErrorEvent event, Emitter<MediaPickState> emit) {
    emit(MediaPickerError(message: event.message));
  }

  
}
