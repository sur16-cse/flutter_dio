import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;

  final baseUrl = "https://reqres.in/";
  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initialiseInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initialiseInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper( onRequest: (request, handler) {
        print("${request.method} ${request.baseUrl}${request.path}");
        return handler.next(request);
      },
        onResponse: (response, handler) {
          print("${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          print("${error.message}");
          return handler.next(error);
        },),
    );
  }
}