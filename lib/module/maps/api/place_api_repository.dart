// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  final int _maxCharactersPerLine = 200;
}

class PlaceApiRepository {
  final Dio _dio = Dio();

  Future<Response> getAutoComplete(
      {required String api, params, bearerToken, apiKey}) async {
    Response response = await _getApi('${api}place-search',
        queryParam: params, bearerToken: bearerToken, apiKey: apiKey);
    return response;
  }

  Future<Response> getPlaceDetail(
      {required String api, params, bearerToken, apiKey}) async {
    Response response = await _getApi('${api}place-detail',
        queryParam: params, bearerToken: bearerToken, apiKey: apiKey);
    return response;
  }

  Future<Response> _getApi(url, {queryParam, bearerToken, apiKey}) async {
    _dio.interceptors.add(LoggingInterceptor());
    _dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    _dio.options.headers['Accept'] = '*/*';
    _dio.options.headers['ApiKey'] = apiKey;
    print('-----');
    print(url);
    print(apiKey);
    print(bearerToken);
    print(queryParam.toString());
    print('-----');

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      print('-----');
      print(response.statusCode);
      print('-----');
      return response;
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {}

      print('-----');
      print(error.message);
      print('-----');
      return error.response!;
    }
  }
}
