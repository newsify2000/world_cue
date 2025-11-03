import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:world_cue/core/utils/constants.dart';

import 'exception.dart';
import 'interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  static String baseUrl = "https://gnews.io/api/v4";
  late Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
        contentType: NetworkConstants.contentType));
    dio.interceptors.add(CustomInterceptor());

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 300));
    }
  }

  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuthorizationHeader = false,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                NetworkConstants.authorizationHeaderKey:
                requiresAuthorizationHeader
              },
            ),
      );
      return response;
    } on DioException catch (de) {
      throw BaseApiException.fromDioError(de);
    } on Exception catch (e) {
      throw Exception(e.toString());
    } catch (err) {
      rethrow;
    }
  }


  Future<Response> postRequest(
      {required String endPoint,
      required dynamic data,
      bool requiresAuthorizationHeader = false}) async {
    try {
      return await dio.post(endPoint,
          data: data,
          options: Options(
              headers: {NetworkConstants.authorizationHeaderKey: requiresAuthorizationHeader}));
    } on DioException catch (err) {
      throw BaseApiException.fromDioError(err);
    } on Exception catch (e) {
      throw Exception(e.toString());
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> patchRequest(
      {required String endPoint,
      required dynamic data,
      bool requiresAuthorizationHeader = false}) async {
    try {
      return await dio.patch(endPoint,
          data: data,
          options: Options(
              headers: {NetworkConstants.authorizationHeaderKey: requiresAuthorizationHeader}));
    } on DioException catch (err) {
      throw BaseApiException.fromDioError(err);
    } on Exception catch (e) {
      throw Exception(e.toString());
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> putRequest(
      {required String endPoint,
      required dynamic data,
      bool requiresAuthorizationHeader = false}) async {
    try {
      return await dio.put(endPoint,
          data: data,
          options: Options(
              headers: {NetworkConstants.authorizationHeaderKey: requiresAuthorizationHeader}));
    } on DioException catch (err) {
      throw BaseApiException.fromDioError(err);
    } on Exception catch (e) {
      throw Exception(e.toString());
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> deleteRequest(
      {required String endPoint,
      required dynamic data,
      bool requiresAuthorizationHeader = false}) async {
    try {
      return await dio.delete(endPoint,
          data: data,
          options: Options(
              headers: {NetworkConstants.authorizationHeaderKey: requiresAuthorizationHeader}));
    } on DioException catch (err) {
      throw BaseApiException.fromDioError(err);
    } on Exception catch (e) {
      throw Exception(e.toString());
    } catch (error) {
      rethrow;
    }
  }
}
