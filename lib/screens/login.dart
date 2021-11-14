import 'dart:convert';

import 'package:bloodpressure/constants.dart';
import 'package:bloodpressure/model/user_model.dart';
import 'package:bloodpressure/screens/main_menu.dart';
import 'package:bloodpressure/screens/user_data_record.dart';
import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:bloodpressure/widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                      fun: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await http.post(
                            Uri.parse('https://bloodas.herokuapp.com/v1/login'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              "email": _emailController.text,
                              "password": _passwordController.text
                            }),
                          );
                          Map<String, dynamic> responseJSON =
                              jsonDecode(response.body);

                          if (responseJSON['status'] == 'success') {
                            print(responseJSON);
                            showSnackBar("Login Sucessfully", "");
                            UserModel tempModel = UserModel.fromJson(
                                responseJSON['data']['member'][0]);
                            // print(u.id);

                            Get.to(() => MainMenu(
                                  user: tempModel,
                                ));
                          } else {
                            showErrorSnackBar();
                          }
                        }
                        // Get.to(() => MainMenu());
                      }),
                  const CustomText(text: "O Registrarse"),
                  const SizedBox(height: 10),
                  elevatedButton(
                      text: "REGISTRO",
                      fun: () {
                        Get.to(() => UserDataRecord());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
