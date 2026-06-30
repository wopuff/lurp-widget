import 'dart:io';

/// Checks if the error is a SocketException.
///
/// On VM/native platforms, this checks if the error is an instance of SocketException.
bool isSocketException(Object? error) => error is SocketException;
