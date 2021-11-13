import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class UserDataRecord extends StatelessWidget {
// Mail
// CURP
// Last name
// Mother's last name
// Names)
// Date of birth
// Sex
// Man
// Woman
// Weight kg.
// Height mt.

  final _mailController = TextEditingController();
  final _curpController = TextEditingController();

  final _lastNameController = TextEditingController();
  final _motherNameController = TextEditingController();

  final _weightController = TextEditingController();

  final _heightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const CustomText(
                  text: "Registro de Datos",
                  size: 25,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text:
                      "Somos un equipo de desarrolladores integrado por estudiantes de ingenieria en la facultad de ciencias de la computacion de la Benemerita Universidad Autonoma de Puebla (Buap).",
                  size: 22,
                  align: TextAlign.center,
                ),
                SizedBox(height: Get.width / 1.5),
                elevatedButton(
                    text: "ACERCA DE",
                    fun: () {
                      Get.back();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
