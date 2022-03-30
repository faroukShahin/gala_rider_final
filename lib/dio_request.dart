import 'package:dio/dio.dart';

class DioRequest {

  // static String weSocketUrl = 'ws://192.168.1.6:4444';
  // static String apiUrl = 'http://192.168.1.6:4444/api';

  // static String apiUrl = 'http://gala.ajory.online:4444/api';
  // static String weSocketUrl = 'ws://gala.ajory.online:4444/';
  
  static String apiUrl = 'http://talabat22.herokuapp.com/api';
  static String weSocketUrl = 'ws://talabat22.herokuapp.com/';
  static String apiKey =
      'dsgiodsggnsdfopsdhvnsdoptj9w345390245yweshdfosdehtwtr93wrh9qwo0erh9w0oqreh9qw03rhwq9erfhoashdfoser8or894tasdew9rwrgeo';

  static Dio dio = Dio(BaseOptions(baseUrl: apiUrl, headers: {'key': apiKey}));

  static late Dio dioWithToken;

  static void createDaoInstance(String token) {
    dioWithToken = Dio(
        BaseOptions(baseUrl: apiUrl, headers: {'key': apiKey, 'token': token}));
  }
}
