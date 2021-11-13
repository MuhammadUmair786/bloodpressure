import 'package:bloodpressure/constants.dart';
import 'package:bloodpressure/screens/main_menu.dart';
import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomText(text: "Iniciar Sesion", size: 20),
                const SizedBox(height: 30),
                textFormFeiled(
                  cont: _emailController,
                  hint: "Correo Electronico",
                  keyboard: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                textFormFeiled(
                  cont: _passwordController,
                  hint: "Contrasena",
                  keyboard: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                elevatedButton(
                    text: "LOGIN",
                    fun: () {
                      Get.to(() => MainMenu());
                    }),
                const CustomText(text: "O Registrarse"),
                const SizedBox(height: 10),
                elevatedButton(text: "REGISTRO", fun: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
