import 'package:dio/dio.dart';
import '../failure/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleDioError(exception);
    } else {
      print(exception);
      return Failure(
        failureMessage: 'Un Expected Error, Please try again later',
      );
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(failureMessage: 'Connection timeout with API server');

      case DioExceptionType.sendTimeout:
        return Failure(failureMessage: 'Send timeout with API server');

      case DioExceptionType.receiveTimeout:
        return Failure(failureMessage: 'Receive timeout with API server');

      case DioExceptionType.badCertificate:
        return Failure(failureMessage: 'Bad SSL Certificate');

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.cancel:
        return Failure(failureMessage: 'Request to API server was cancelled');

      case DioExceptionType.connectionError:
        return Failure(failureMessage: 'No Internet Connection');

      case DioExceptionType.unknown:
      default:
        if (error.message != null &&
            error.message!.contains('SocketException')) {
          return Failure(failureMessage: 'No Internet Connection');
        }
        return Failure(
          failureMessage: 'Unexpected error occurred, Please try again',
        );
    }
  }

  static Failure _handleStatusCode(int? statusCode, dynamic responseData) {
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('message')) {
      final message = responseData['message'];
      if (message is String && message.isNotEmpty) {
        return Failure(failureMessage: message);
      } else if (message is List && message.isNotEmpty) {
        return Failure(failureMessage: message.first.toString());
      }
    }

    switch (statusCode) {
      case 400:
        return Failure(failureMessage: 'Bad Request');
      case 401:
        return Failure(failureMessage: 'Unauthorized access');
      case 403:
        return Failure(failureMessage: 'Forbidden access');
      case 404:
        return Failure(failureMessage: 'Resource not found');
      case 409:
        return Failure(failureMessage: 'Conflict occurred');
      case 422:
        return Failure(failureMessage: 'Unprocessable Content');
      case 500:
        return Failure(failureMessage: 'Internal Server Error');
      case 502:
        return Failure(failureMessage: 'Bad Gateway');
      case 503:
        return Failure(failureMessage: 'Service Unavailable');
      default:
        return Failure(
          failureMessage: 'Received invalid status code: $statusCode',
        );
    }
  }
}
