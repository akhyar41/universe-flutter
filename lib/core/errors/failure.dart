class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("No internet connection");
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super("Session expired. Please login again.", statusCode: 401);
}
