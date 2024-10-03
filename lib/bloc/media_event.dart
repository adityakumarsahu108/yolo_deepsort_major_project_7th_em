// media_event.dart
abstract class MediaPickEvent {}

class ToggleMediaModeEvent extends MediaPickEvent {}

class PickImageEvent extends MediaPickEvent {}

class PickVideoEvent extends MediaPickEvent {}

// New event for handling errors
class MediaPickErrorEvent extends MediaPickEvent {
  final String message;

  MediaPickErrorEvent(this.message);
}
