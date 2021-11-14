import 'dart:convert';

import 'package:bloodpressure/screens/login.dart';
// import 'package:bloodpressure/screens/main_menu.dart';
import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:bloodpressure/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class UserDataRecord extends StatefulWidget {
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

  @override
  State<UserDataRecord> createState() => _UserDataRecordState();
}

class _UserDataRecordState extends State<UserDataRecord> {
  final _mailController = TextEditingController();

  final _curpController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _motherNameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _weightController = TextEditingController();

  final _heightController = TextEditingController();

  final _dateController = TextEditingController();

  final _genderController = TextEditingController(text: "male");

  late DateTime date;
  int groupValue = 1;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const CustomText(
                    text: "Registro de Datos",
                    size: 25,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  userDataRecordItem(
                    "Correo",
                    _mailController,
                    "ej: carlos@gmail.com",
                    TextInputType.emailAddress,
                  ),
                  userDataRecordItem(
                    "CURP",
                    _curpController,
                    "ej: MMPKJ2523jnkj",
                    TextInputType.text,
                  ),
                  userDataRecordItem(
                    "Apellido Paterno",
                    _lastNameController,
                    "ej: Veassa",
                    TextInputType.name,
                  ),
                  userDataRecordItem(
                    "Apellido Materno",
                    _motherNameController,
                    "ej: Marquez",
                    TextInputType.name,
                  ),
                  userDataRecordItem(
                    "Nombre(s)",
                    _phoneController,
                    "ej: +92 xxx xxxxxxxx",
                    TextInputType.number,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Fecha de Nacimiento",
                          size: 19,
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              date = (await showDatePicker(
                                // currentDate: DateTime.now(),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1947),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                _dateController.text =
                                    Jiffy(value).format("dd/MM/yyy");
                              }))!;
                            } catch (ex) {
                              print(ex);
                            }
                          },
                          child: AbsorbPointer(
                            child: Container(
                              width: Get.width / 1.8,
                              child: textFormFeiled(
                                cont: _dateController,
                                hint: "25/02/1961",
                                keyboard: TextInputType.number,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Sexo",
                      size: 19,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: RadioListTile(
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (int? value) {
                            setState(() {
                              groupValue = value!;
                              _genderController.text = "male";
                            });
                          },
                          title: const Text('Hombre'),
                          // contentPadding: EdgeInsets.symmetric(horizontal: 5)
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: 2,
                          groupValue: groupValue,
                          onChanged: (int? value) {
                            setState(() {
                              groupValue = value!;
                              _genderController.text = "female";
                            });
                          },
                          title: const Text('Mujer'),
                          // contentPadding: EdgeInsets.symmetric(horizontal: 5)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: userDataRecordItem(
                          "Peso kg.",
                          _weightController,
                          "ej: 68.6",
                          TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: userDataRecordItem(
                          "Altura mt",
                          _heightController,
                          "ej: 1.79",
                          TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  elevatedButton(
                      text: "ENVIAR",
                      fun: () async {
                        if (_formKey.currentState!.validate()) {
                          // Map<String, String> dataToPost = {
                          //   "email": _mailController.text,
                          //   "password": _curpController.text,
                          //   "first_name": _lastNameController.text,
                          //   "last_name": _motherNameController.text,
                          //   "dbo": _dateController.text,
                          //   "gender": _genderController.text,
                          //   "number": _phoneController.text,
                          //   "height": _heightController.text,
                          //   "weight": _weightController.text
                          // };
                          // print(_genderController.text);
                          // final Map<String, String> _headers = {
                          //   "Content-Type": "application/json",
                          //   "Accept": "application/json",
                          // };
                          final response = await http.post(
                            Uri.parse(
                                'https://bloodas.herokuapp.com/v1/member'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              "email": _mailController.text,
                              "password": _curpController.text,
                              "first_name": _lastNameController.text,
                              "last_name": _motherNameController.text,
                              "dbo": _dateController.text,
                              "gender": _genderController.text,
                              "number": _phoneController.text,
                              "height": _heightController.text,
                              "weight": _weightController.text
                            }),
                          );
                          // if(response.body)
                          Map<String, dynamic> responseJSON =
                              jsonDecode(response.body);

                          if (responseJSON['status'] == 'success') {
                            showSnackBar("Login Created Sucessfully", "");
                            Get.to(() => Login());
                          } else {
                            showErrorSnackBar();
                          }
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userDataRecordItem(
    String heading,
    TextEditingController controller,
    String hint,
    TextInputType input,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: heading,
            size: 19,
            weight: FontWeight.w500,
          ),
          Container(
            width: Get.width / 1.8,
            child: textFormFeiled(
              cont: controller,
              hint: hint,
              keyboard: input,
            ),
          )
        ],
      ),
    );
  }
}
