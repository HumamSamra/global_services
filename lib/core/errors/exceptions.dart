import 'dart:async';

import 'package:equatable/equatable.dart';

class BaseException extends Equatable implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const BaseException(this.message, [this.stackTrace]);

  @override
  String toString() => message.toString();

  @override
  List<Object?> get props => [message, stackTrace];
}

class SereverException extends BaseException {
  final dynamic error;
  final int statusCode;
  final String endPointUrl;
  const SereverException({
    required String message,
    StackTrace? stackTrace,
    required this.error,
    required this.endPointUrl,
    required this.statusCode,
  }) : super(message, stackTrace);
  @override
  List<Object?> get props =>
      [message, stackTrace, error, endPointUrl, statusCode];
}

class AppTimeoutException extends TimeoutException {
  final int statusCode;
  final String endPointUrl;

  AppTimeoutException({
    required this.endPointUrl,
    required String message,
    required this.statusCode,
  }) : super(message);
}

class BadResponseException extends BaseException {
  final dynamic error;
  final int statusCode;
  final String endPointUrl;
  const BadResponseException({
    required String message,
    StackTrace? stackTrace,
    required this.error,
    required this.endPointUrl,
    required this.statusCode,
  }) : super(message, stackTrace);

  String get errorMsg {
    String errorMsg = '';
    if (error is Map) {
      error.forEach((key, value) {
        errorMsg =
            value.runtimeType == List ? value[0].toString() : value.toString();
      });
    } else if (error is String) {
      errorMsg = error.toString();
    }

    return errorMsg;
  }

  @override
  List<Object?> get props =>
      [message, stackTrace, error, endPointUrl, statusCode];
}

class UnauthorizedException extends BaseException {
  final dynamic error;
  final int statusCode;
  final String endPointUrl;
  const UnauthorizedException({
    required String message,
    StackTrace? stackTrace,
    required this.error,
    required this.endPointUrl,
    required this.statusCode,
  }) : super(message, stackTrace);

  String get errorMsg {
    String errorMsg = '';
    if (error is Map) {
      error.forEach((key, value) {
        errorMsg =
            value.runtimeType == List ? value[0].toString() : value.toString();
      });
    }

    return errorMsg;
  }

  @override
  List<Object?> get props =>
      [message, stackTrace, error, endPointUrl, statusCode];
}

class ServerUrlException extends BaseException {
  final dynamic error;
  const ServerUrlException({
    this.error,
    required String message,
  }) : super(message);
  String get errorMsg => message;
}

class NotFoundException extends BaseException {
  final dynamic error;
  final int statusCode;
  final String endPointUrl;
  const NotFoundException({
    required String message,
    StackTrace? stackTrace,
    required this.error,
    required this.endPointUrl,
    required this.statusCode,
  }) : super(message, stackTrace);
  @override
  List<Object?> get props =>
      [message, stackTrace, error, endPointUrl, statusCode];
}
