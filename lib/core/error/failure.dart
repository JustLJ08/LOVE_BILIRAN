import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Common failure types (you can expand these as needed)
class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server Failure"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No Internet Connection"]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = "Database Error"]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = "Authentication Failed"]);
}
