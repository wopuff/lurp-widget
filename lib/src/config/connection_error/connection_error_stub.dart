/// Checks if the error is a SocketException.
///
/// On web platforms, this always returns false since SocketException is not available.
bool isSocketException(Object? error) => false;
