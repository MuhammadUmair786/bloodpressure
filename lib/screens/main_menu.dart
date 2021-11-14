import 'package:bloodpressure/constants.dart';
import 'package:bloodpressure/model/user_model.dart';
import 'package:bloodpressure/screens/about_us.dart';
import 'package:bloodpressure/screens/data_entry.dart';
import 'package:bloodpressure/screens/history.dart';
import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  final UserModel user;

  MainMenu({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  const SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: elevatedButton(
                    text: "CERRAR SESION",
                    fun: () {
                      // Get.to(() => MainMenu());
                    }),
              ),
              const SizedBox(height: 30),

              const CustomText(text: "Menu Principal", size: 20),

              const SizedBox(height: 20),
              elevatedButton(
                  text: "INGRESAR DATOS",
                  fun: () {
                    Get.to(() => DataEntry(
                          memberID: user.id,
                        ));
                  }),
              const SizedBox(height: 10),
              elevatedButton(
                  text: "HISTORIAL DE MEDIDAS",
                  fun: () {
                    Get.to(() => History(
                          memberID: user.id,
                        ));
                  }),
              // const CustomText(text: "O Registrarse"),
              SizedBox(height: Get.width / 1.3),
              elevatedButton(
                  text: "ACERCA DE",
                  fun: () {
                    Get.to(() => const AboutUs());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
