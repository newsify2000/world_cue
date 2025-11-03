import 'package:dio/dio.dart';

class BaseApiException implements Exception {
  String? errorMessage;
  int? statusCode;

  BaseApiException(this.errorMessage, this.statusCode);

  BaseApiException.fromDioError(DioException dioError) {
    if (dioError.response?.data != null &&
        dioError.response!.data['status'] == "error" &&
        dioError.response!.data['message'] != null) {
      errorMessage = dioError.response!.data['message'];
    } else {
      switch (dioError.type) {
        case DioExceptionType.cancel:
          statusCode = dioError.response?.statusCode;
          errorMessage = "Request to the server was cancelled";
          break;

        case DioExceptionType.connectionError:
          statusCode = dioError.response?.statusCode;
          errorMessage = "Connection Timed out";
          break;

        case DioExceptionType.receiveTimeout:
          statusCode = dioError.response?.statusCode;
          errorMessage = "Receiving Timeout occurred";
          break;

        case DioExceptionType.sendTimeout:
          statusCode = dioError.response?.statusCode;
          errorMessage = "Request send timeout";
          break;

        case DioExceptionType.unknown:
          statusCode = dioError.response?.statusCode;
          errorMessage = _handleStatusCode(dioError.response?.statusCode);
          break;

        case DioExceptionType.badResponse:
          statusCode = dioError.response?.statusCode;
          if (dioError.message != null &&
              dioError.message!.contains('Socket Exception')) {
            errorMessage = "No Internet connection available";
            break;
          }
          errorMessage = "Unexpected error occurred";
          break;

        default:
          statusCode = dioError.response?.statusCode;
          errorMessage = "Something went wrong !!!";
          break;
      }
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'Access Forbidden. Possibly the user has been deactivated by the admin.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      case 503:
        return 'This service is not ready to serve traffic. If you are the site owner, please check that your service is passing health checks.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() {
    return errorMessage ?? "Error message not available";
  }
}

class ImageUploadingException extends BaseApiException {
  ImageUploadingException(BaseApiException e)
      : super(e.errorMessage, e.statusCode);
}

class FileUploadingException extends BaseApiException {
  FileUploadingException(BaseApiException e)
      : super(e.errorMessage, e.statusCode);
}
