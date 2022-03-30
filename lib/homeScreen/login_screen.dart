import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'تسجيل الدخول',
          style: GoogleFonts.almarai(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ))
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              Text(
                'البريد الإلكتروني',
                style: GoogleFonts.almarai(
                    fontSize: 14, fontWeight: FontWeight.bold, height: 3),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (v) => _controller.email = v,
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'كلمة السر',
                style: GoogleFonts.almarai(
                    fontSize: 14, fontWeight: FontWeight.bold, height: 3),
              ),
              const SizedBox(
                height: 15,
              ),
              ValueBuilder<bool?>(
                initialValue: true,
                builder: (value, update) => TextField(
                  obscureText: value!,
                  maxLines: 1,
                  onChanged: (v) => _controller.password = v,
                  decoration: InputDecoration(
                      suffixIcon: TextButton(
                        onPressed: () => update(!value),
                        child: Text(
                          value ? 'إظهار' : 'اخفاء',
                          style: GoogleFonts.almarai(
                              color: Colors.black54, fontSize: 12),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Obx(() => MaterialButton(
                    onPressed: _controller.isLoading ? null : _controller.login,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: mainColor,
                    disabledColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'تسجيل الدخول',
                        style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
