import 'dart:io';

import 'package:dio/dio.dart';
import 'package:global_services/core/errors/exceptions.dart';
import 'package:global_services/core/network/api_strings.dart';

class DioHelper {
  final Dio _dio;
  DioHelper(this._dio) {
    _dio.options.baseUrl = ApiStrings.baseUrl;

    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  Future get(String endPoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      _dio.options.headers = await getRequestHeader();

      final response =
          await _dio.get(endPoint, queryParameters: queryParameters);

      return response.data;
    } on DioException catch (e) {
      handleDioErrors(e);
    }
  }

  handleDioErrors(DioException err) {
    if (err.type == DioExceptionType.connectionError) {
      throw AppTimeoutException(
        endPointUrl: err.requestOptions.path,
        statusCode: err.response?.statusCode ?? 500,
        message: "No internet",
      );
    }
    if (err.type == DioExceptionType.connectionTimeout) {
      throw AppTimeoutException(
        endPointUrl: err.requestOptions.path,
        statusCode: 500,
        message: "Connection Time Out",
      );
    } else if (err.response!.statusCode == 401) {
      return UnauthorizedException(
        endPointUrl: err.requestOptions.path,
        error: err.response?.data,
        message: err.message!,
        statusCode: err.response!.statusCode!,
      );
    } else if (err.response!.statusCode! >= 500) {
      throw SereverException(
        endPointUrl: err.requestOptions.path,
        error: err.error,
        message: err.response?.statusMessage ?? err.message!,
        statusCode: err.response!.statusCode!,
      );
    } else if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 400) {
      throw BadResponseException(
        endPointUrl: err.requestOptions.path,
        error: err.response?.data,
        message: err.message!,
        statusCode: err.response!.statusCode!,
      );
    } else if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 404) {
      throw NotFoundException(
        endPointUrl: err.requestOptions.path,
        error: err.response?.data,
        message: 'Something went wrong',
        statusCode: err.response!.statusCode!,
      );
    } else {
      throw SereverException(
        endPointUrl: err.requestOptions.path,
        error: err.error,
        message: err.message!,
        statusCode: err.response!.statusCode!,
      );
    }
  }

  Future delete(String endPoint, int id) async {
    try {
      _dio.options.headers = await getRequestHeader();
      final response = await _dio.delete("$endPoint$id/");

      return response.data;
    } on DioException catch (e) {
      handleDioErrors(e);
    }
  }

  Future post(String endPoint,
      {Map<String, dynamic>? customHeader, Map<String, dynamic>? data}) async {
    try {
      _dio.options.headers = await getRequestHeader(customHeader: customHeader);
      final response = await _dio.post(endPoint, data: data);

      return response.data;
    } on DioException catch (e) {
      handleDioErrors(e);
    }
  }

  Future update(String endPoint, {Map<String, dynamic>? data}) async {
    try {
      _dio.options.headers = await getRequestHeader();
      final response = await _dio.patch(endPoint, data: data);

      return response.data;
    } on DioException catch (e) {
      handleDioErrors(e);
    }
  }

  Future uploadImages(String endPoint, Map<String, File> data) async {
    try {
      _dio.options.headers = await getRequestHeader();
      FormData formData = FormData.fromMap(data);
      formData.files.add(MapEntry(data.entries.first.key,
          await MultipartFile.fromFile(data.entries.first.value.path)));
      final response = await _dio.post(endPoint, data: formData);

      return response.data;
    } on DioException catch (e) {
      handleDioErrors(e);
    }
  }

  Future<Map<String, dynamic>> getRequestHeader(
      {Map<String, dynamic>? customHeader}) async {
    return {
      'Content-Type': "application/json",
      "Accept-Language": "en",
      if (customHeader != null) ...customHeader,
    };
  }
}
