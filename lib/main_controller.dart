import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gala_rider/dio_request.dart';
import 'package:gala_rider/homeScreen/currentOrders/currentOrderCard.dart';
import 'package:gala_rider/homeScreen/login_screen.dart';
import 'package:gala_rider/model/delivery_model.dart';
import 'package:gala_rider/model/order_model.dart';
import 'package:gala_rider/model/restaurant_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/io.dart';
import 'package:location/location.dart' as loc;

class MainController extends GetxController {
  final index = Rx(0);
  final _totalEarning = RxDouble(0.0);
  final _delivery = Rxn<DeliveryModel>();
  final _isConnected = Rx(false);
  final _orders = RxList<OrderModel>();
  final _previousOrders = RxList<OrderModel>();
  final _restaurants = RxList<RestaurantModel>();
  final _latitude = RxDouble(0.0);
  final _longitude = RxDouble(0.0);
  final _currentOrder = Rxn<OrderModel>();

//maps
  final mapMarker = <Marker>[].obs;
  final polylines = <PolylineId, Polyline>{}.obs;
  PolylinePoints polylinePoints = PolylinePoints();
  final polylineList = <LatLng>[].obs;

//maps after picking
  final mapMarker2 = <Marker>[].obs;
  final polylines2 = <PolylineId, Polyline>{}.obs;
  PolylinePoints polylinePoints2 = PolylinePoints();
  final polylineList2 = <LatLng>[].obs;

  DeliveryModel? get delivery => _delivery.value;

  bool get isConnected => _isConnected.value;

  List<OrderModel> get orders => _orders;

  List<OrderModel> get previousOrders => _previousOrders;

  OrderModel? get currentOrder => _currentOrder.value;

  List<RestaurantModel> get restaurants => _restaurants;

  StreamSubscription? _locationStreamSubscription;

  IOWebSocketChannel? _socketChannel;

  String? _token;

  double get totalEarning => _totalEarning.value;

  double get latitude => _latitude.value;

  double get longitude => _longitude.value;

  final List<String> rejectedOrders = [];

  @override
  void onInit() {
    super.onInit();
    _token = Hive.box('main').get('token');
    if (_token != null) {
      DioRequest.createDaoInstance(_token!);
      _startLocationTracking();
      _get_location();
      connectWithWebSocket();
      FirebaseMessaging.instance.subscribeToTopic('deliverers');
    } else {
      Get.offAll(LoginScreen());
    }
  }

  @override
  void onClose() {
    _endLocationTracking();
    super.onClose();
  }

  void toggleState() async {
    if (!delivery!.deliveryManStatus) {
      final isLocationEnable = await _isLocationEnable();
      if (!isLocationEnable) return;
    }

    bool r = false;

    try {
      final result =
          await DioRequest.dioWithToken.post('/deliveryPanel/status', data: {
        'deliveryManStatus': !delivery!.deliveryManStatus,
      });

      r = result.data['message'] == 'success';

      if (r) {
        _delivery.value!.deliveryManStatus = !delivery!.deliveryManStatus;
        _delivery.refresh();

        if (delivery!.deliveryManStatus) {
          _startLocationTracking();
        } else {
          _endLocationTracking();
        }
      }
    } catch (_) {}

    Get.defaultDialog(
      title: r ? 'تم بنجاح' : 'لم يتم التغيير',
      middleText: r ? ' تم تغيير الحالة ' : "لم يتم تغيير الحالة حاول مرة أخري",
      textCancel: 'حسنا',
      onCancel: Get.back,
    );
  }

  void _startLocationTracking() {
    _locationStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    )).listen((Position? position) {
      if (position != null) _sendLocation(position);
      _latitude.value = position!.latitude;
      _longitude.value = position.longitude;
    });
  }

  void _get_location() {
    loc.Location location = loc.Location();
    location.onLocationChanged.listen((event) {
      sendLocationWithLocationPackage(event);
      _latitude.value = event.latitude!;
      _longitude.value = event.longitude!;
    });
  }

  void _endLocationTracking() {
    _locationStreamSubscription?.cancel();
  }

  void _sendLocation(Position position) {
    _sendDataToServer('new_location',
        {'late': position.latitude, 'long': position.longitude});
  }

  sendLocationWithLocationPackage(loc.LocationData event) {
    print('sent');
    _sendDataToServer(
        'new_location', {'late': event.latitude, 'long': event.longitude});
  }

  addMarker() async {
    try {
      if (currentOrder != null) {
        if (!currentOrder!.inTheWay) {
          print('there');
          final restaurantInfo =
              restaurants.firstWhere((e) => e.id == currentOrder!.restId);
          mapMarker.add(Marker(
            markerId: MarkerId('driver'),
            position: LatLng(latitude, longitude),
          ));
          mapMarker.add(Marker(
            markerId: MarkerId('restaurant'),
            position: LatLng(restaurantInfo.latitude, restaurantInfo.longitude),
          ));
          PolylinePoints polylinePoints = PolylinePoints();
          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
            'AIzaSyDiTW5YZ_Tq-BwzOu1HIIAR_qh8yXmJnm8',
            PointLatLng(
              latitude,
              longitude,
            ),
            PointLatLng(restaurantInfo.latitude, restaurantInfo.longitude),
          );
          result.points.forEach((element) {
            polylineList.add(LatLng(element.latitude, element.longitude));
          });
          final polylineId = const PolylineId('1');
          final Polyline polyline = Polyline(
            polylineId: polylineId,
            consumeTapEvents: true,
            color: Colors.greenAccent,
            width: 5,
            points: polylineList,
          );
          polylines[polylineId] = polyline;
        } else {
          print('here');
          mapMarker2.add(Marker(
            markerId: MarkerId('driver'),
            position: LatLng(latitude, longitude),
          ));
          mapMarker2.add(Marker(
            markerId: MarkerId('restaurant'),
            position: LatLng(
                currentOrder!.userLatitude!, currentOrder!.userLongitude!),
          ));
          PolylinePoints polylinePoints = PolylinePoints();
          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
            'AIzaSyDiTW5YZ_Tq-BwzOu1HIIAR_qh8yXmJnm8',
            PointLatLng(
              latitude,
              longitude,
            ),
            PointLatLng(
                currentOrder!.userLatitude!, currentOrder!.userLongitude!),
          );
          result.points.forEach((element) {
            polylineList2.add(LatLng(element.latitude, element.longitude));
          });
          final polylineId = PolylineId('${currentOrder!.id}');
          final Polyline polyline = Polyline(
            polylineId: polylineId,
            consumeTapEvents: true,
            color: Colors.greenAccent,
            width: 5,
            points: polylineList2,
          );
          polylines2[polylineId] = polyline;
        }
      }
    } catch (e) {}
  }

  void onRejectOrder(OrderModel orderModel) {
    _orders.remove(orderModel);
    rejectedOrders.add(orderModel.id);
  }

  Future<bool> _isLocationEnable() async {
    bool isLocationEnable = false;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Get.defaultDialog(
        title: 'GPS مطلوب',
        middleText: 'من فضلك قم بتفعيل خدمة GPS',
        textCancel: 'حسنا',
        onCancel: Get.back,
      );
    }

    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Get.defaultDialog(
          title: 'الاذن مطلوب',
          middleText: 'من فضلك قم باعطاء التطبيق الاذن بالوصول الي موقعك',
          textCancel: 'حسنا',
          onCancel: Get.back,
        );
      }
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) isLocationEnable = true;

    return isLocationEnable;
  }

  void acceptOrder(OrderModel orderModel) {
    _sendDataToServer('accept_order', orderModel.id);
  }

  void onOrderCompleted() {
    if (currentOrder != null) {
      _sendDataToServer('onOrderCompleted', '');
    }
  }

  void onDeliveryOnWay() {
    if (currentOrder != null) {
      _sendDataToServer('onDeliveryOnWay', '');
    }
  }

  void connectWithWebSocket() {
    if (!isConnected) {
      _socketChannel?.sink.close();

      _socketChannel = IOWebSocketChannel.connect(
        DioRequest.weSocketUrl + '/?key=${DioRequest.apiKey}&token=$_token',
      );
      _socketChannel?.stream.listen(_onServerData);
      _socketChannel?.sink.done.then((value) {
        _isConnected.value = false;
        Future.delayed(const Duration(seconds: 30))
            .then((value) => connectWithWebSocket());
      });
    }
  }

  Future<String> getPlace(lat, lng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, lng, localeIdentifier: 'ar');
    Placemark placeMark = placemarks[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
    return address;
  }

  void _sendDataToServer(String type, dynamic data) {
    _socketChannel?.sink
        .add(const JsonEncoder().convert({'type': type, 'data': data}));
  }

  void _onServerData(dynamic data) {
    try {
      if (data == 'connected') {
        _isConnected.value = true;
      } else {
        final json = const JsonDecoder().convert(data);
        switch (json['type']) {
          case 'orders':
            _orders.value = (json['data'] as List)
                .map((e) => OrderModel.fromMap(e))
                .toList();
            break;

          case 'rests':
            _restaurants.value = (json['data'] as List)
                .map((e) => RestaurantModel.fromMap(e))
                .toList();
            break;

          case 'info':
            _delivery.value = DeliveryModel.fromMap(json['data']);
            break;

          case 'current_order':
            _currentOrder.value = OrderModel.fromMap(json['data']);
            break;

          case 'previousOrders':
            _previousOrders.value = (json['data'] as List)
                .map((e) => OrderModel.fromMap(e))
                .toList();
            break;

          case 'new_order':
            final order = OrderModel.fromMap(json['data']);
            if (rejectedOrders.firstWhereOrNull((e) => e == order.id) == null) {
              _orders.add(order);
            }

            break;
          case 'request_order':
            final order = OrderModel.fromMap(json['data']);
            final restaurant =
                restaurants.firstWhere((e) => e.id == order.restId);

            Get.defaultDialog(
              title: 'طلب جديد',
              onWillPop: () => Future(() => false),
              barrierDismissible: false,
              middleText:
                  'يوجد طلب جديد من مطعم ${restaurant.nameAr} \n هل تريد عرض تفاصيل الطلب؟',
              textConfirm: 'نعم',
              textCancel: 'لا',
              confirmTextColor: Colors.white,
              onCancel: () {
                _sendDataToServer('request_order_rejected', {
                  'rest': restaurant.id,
                  'order': order.orderNumber,
                });
              },
              onConfirm: () {
                Get.back();
                Get.dialog(
                  AlertDialog(
                    content: SizedBox(
                      width: Get.width,
                      height: Get.height * .8,
                      child: SingleChildScrollView(
                        child: currentOrderCard(
                          orderModel: order,
                          onAcceptClick: () => acceptOrder(order),
                          restaurant: restaurant,
                          onReject: () {
                            _sendDataToServer('request_order_rejected', {
                              'rest': restaurant.id,
                              'order': order.orderNumber,
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
              },
            );
            break;

          case 'remove_order':
            _orders.removeWhere((e) => e.id == json['data']);
            break;

          case 'order_accepted':
            final order = OrderModel.fromMap(json['data']);

            _currentOrder.value = order;

            Get.defaultDialog(
                title: 'تم قبول الطلب',
                middleText:
                    'تم قبول الطلب رقم ${order.orderNumber} من فضلك قم بالوصول الي المطعم لاستلامه'
                    '\n ستجد كل التفاصيل في الطلب الحالي'
                    '\n اذا لم تصل للمطعم في خلال 30 دقيقة سيتم ارسال الطلب الي كابتن أخر',
                textCancel: 'حسنا',
                onCancel: Get.back,
                confirmTextColor: Colors.white);
            break;

          case 'order_not_available':
            Get.defaultDialog(
                title: 'الطلب غير متاح',
                middleText: 'الطلب رقم ${json['number']} غير متاح حاليا',
                textCancel: 'حسنا',
                onCancel: Get.back,
                confirmTextColor: Colors.white);
            break;

          case 'onDeliveryOnWayDone':
            Get.defaultDialog(
                title: 'تم تغيير حالة الطلب بنجاح',
                middleText: 'تم تغيير حالة الطلب الي في الطريق الي العميل',
                textCancel: 'حسنا',
                onCancel: Get.back,
                confirmTextColor: Colors.white);
            _currentOrder.value?.inTheWay = true;
            _currentOrder.refresh();
            break;

          case 'onOrderCompletedDone':
            Get.defaultDialog(
                title: 'تم التسليم بنجاح',
                middleText:
                    'تم اكتمال الطلب بنجاح الان تستطيع الحصول علي طلب أخر',
                textCancel: 'حسنا',
                onCancel: Get.back,
                confirmTextColor: Colors.white);
            _previousOrders.add(currentOrder!);
            _currentOrder.value = null;
            break;

          case 'must_complete_current_order':
            Get.defaultDialog(
                title: 'فشل',
                middleText: 'قم باكمال الطلب الحالي أولاً',
                textCancel: 'حسنا',
                onCancel: Get.back,
                confirmTextColor: Colors.white);
            break;

          case 'rest_cancel_order':
            if (currentOrder != null && currentOrder!.id == json['data']) {
              _currentOrder.value = null;
              Get.defaultDialog(
                  title: 'تم الغاء الطلب',
                  middleText: 'عذراً تم الفاء الطلب الحالي بواسطة المطعم',
                  textCancel: 'حسنا',
                  onCancel: Get.back,
                  confirmTextColor: Colors.white);
            }
            break;
        }
      }
    } catch (e) {}
  }

  void call_number(phone) async {
    FlutterPhoneDirectCaller.callNumber(phone);
  }
}
