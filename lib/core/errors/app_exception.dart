class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super("Unauthorized", statusCode: 401);
}

class NetworkException extends AppException {
  const NetworkException() : super("Network error. Please check your connection.");
}

class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

class NotFoundException extends AppException {
  const NotFoundException() : super("Resource not found", statusCode: 404);
}
