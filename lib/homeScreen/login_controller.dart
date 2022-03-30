import 'package:dio/dio.dart';
import 'package:gala_rider/dio_request.dart';
import 'package:gala_rider/homeScreen/homeScreenController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  final _isLoading = Rx(false);

  String? email, password;

  bool get isLoading => _isLoading.value;

  void login() async {
    if (email == null || !email!.isEmail) {
      _renderError('البريد الالكتروني ليس كافيا');
    } else if (password == null && password!.length < 4) {
      _renderError('كلمة السر ليست كافية');
    } else {
      try {
        _isLoading.value = true;

        final result = await DioRequest.dio.post(
          '/deliveryPanel/login',
          data: {'mail': email, 'password': password},
        );

        await Hive.box('main').put('token', result.data['token']);

        Get.offAll(HomeScreenController());

      } catch (e) {
        if (e is DioError && e.response?.data['message'] != null) {
          _renderError(e.response?.data['message']);
        } else {
          _renderError('خطأ غير معروف');
        }
      }
      _isLoading.value = false;
    }
  }

  void _renderError(String error) {
    Get.snackbar('خطأ', error,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10));
  }
}
