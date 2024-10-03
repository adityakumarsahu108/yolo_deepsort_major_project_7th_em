// media_state.dart
import 'dart:io';

abstract class MediaPickState {}

class MediaPickerInitial extends MediaPickState {}

class MediaPickerModeChanged extends MediaPickState {
  final bool isImageMode;

  MediaPickerModeChanged({required this.isImageMode});
}

class MediaPickerImagePicked extends MediaPickState {
  final File image;

  MediaPickerImagePicked(this.image);
}

class MediaPickerVideoPicked extends MediaPickState {
  final File video;

  MediaPickerVideoPicked(this.video);
}

// New error state
class MediaPickerError extends MediaPickState {
  final String message;

  MediaPickerError({required this.message});
}
