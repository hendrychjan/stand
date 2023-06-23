enum LocationServiceExceptionType {
  permissionDenied,
  permissionDeniedForever,
  serviceUnavailable,
  unknown,
}

class LocationServiceException {
  final LocationServiceExceptionType type;
  final String message;

  LocationServiceException({
    this.type = LocationServiceExceptionType.unknown,
    this.message = "Unknown error",
  });

  @override
  String toString() {
    return 'LocationServiceException{type: $type, message: $message}';
  }
}
