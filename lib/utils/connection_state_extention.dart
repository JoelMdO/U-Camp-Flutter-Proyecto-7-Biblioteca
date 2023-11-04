import 'package:books_app/cubit/api_connection_cubit.dart';

///To facilitate the connection to the API on any of the widgets which require
///to do it, the [toBool] will be modified according to the [ApiConnectionState]
///if its [connected] to be change as [true] or false as required.
///
extension ConnectionStateExtension on ApiConnectionState {
  bool toBool() {
    switch (this) {
      case ApiConnectionState.connected:
        return true;
      default:
        return false;
    }
  }
}
