import 'dart:convert';

import 'package:bloodpressure/screens/history.dart';
import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:bloodpressure/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class DataEntry extends StatelessWidget {
  final String memberID;
  final _dateController = TextEditingController();
  final _weightController = TextEditingController();

  final _pulseController = TextEditingController();
  final _sisController = TextEditingController();

  final _diaController = TextEditingController();
  late DateTime date;
  final _formKey = GlobalKey<FormState>();

  DataEntry({required this.memberID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const CustomText(
                    text: "Ingresar Datos",
                    size: 25,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    text:
                        "A continuación llene el formato con los datos que aparecen en la pantalla de su monitor de presión arterial y presione el boton Registrar",
                    size: 20,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: CustomText(
                          text: "Fecha",
                          size: 19,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              date = (await showDatePicker(
                                // currentDate: DateTime.now(),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 15)),
                              ).then((value) {
                                _dateController.text =
                                    Jiffy(value).format("dd/MM/yyy");
                              }))!;

                              // if (date != null)
                              //   _dateController.text =
                              //       Jiffy([date]).yMMMMd;
                            } catch (ex) {
                              print(ex);
                            }
                          },
                          child: AbsorbPointer(
                              child: TextFormField(
                            controller: _dateController,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "DD-MM-AA",
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '???';
                              }
                              return null;
                            },
                          )

                              // textFormFeiled(
                              //     cont: _dateController,
                              //     hint: "DD-MM-AA",
                              //     keyboard: TextInputType.number,
                              //     align: TextAlign.center),
                              ),
                        ),
                      ),
                      const Expanded(flex: 1, child: CustomText(text: "  "))
                    ],
                  ),
                  const SizedBox(height: 10),
                  dataEntryItem("Peso:", _weightController, "60", "Kg"),
                  const SizedBox(height: 10),
                  dataEntryItem("Pulso:", _pulseController, "70", null),
                  const SizedBox(height: 10),
                  dataEntryItem("SIS mmHg:", _sisController, "120", null),
                  const SizedBox(height: 10),
                  dataEntryItem("DIA mmHg:", _diaController, "78", null),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      elevatedButton(
                          text: "VOLVER",
                          fun: () {
                            Get.back();
                          }),
                      elevatedButton(
                          text: "REGISTRAR",
                          fun: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await http.post(
                                Uri.parse(
                                    'https://bloodas.herokuapp.com/v1/information'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  "date": _dateController.text,
                                  "peso": _weightController.text,
                                  "pulso": _pulseController.text,
                                  "SIS": _sisController.text,
                                  "DIA": _diaController.text,
                                  "member_id": memberID
                                }),
                              );
                              Map<String, dynamic> responseJSON =
                                  jsonDecode(response.body);

                              if (responseJSON['status'] == 'success') {
                                print(responseJSON);
                                showSnackBar("Data Added Sucessfully", "");
                                // UserModel tempModel = UserModel.fromJson(
                                //     responseJSON['data']['member'][0]);
                                // // print(u.id);

                                // Get.to(() => History(memberID: memberID,));
                              } else {
                                showErrorSnackBar();
                              }
                            }
                            // Get.to(() => MainMenu());
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dataEntryItem(String heading, TextEditingController controller,
      String hint, String? postfix) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomText(
            text: heading,
            size: 19,
          ),
        ),
        Expanded(
          flex: 5,
          child: textFormFeiled(
              cont: controller,
              hint: hint,
              keyboard: TextInputType.number,
              align: TextAlign.center),
        ),
        Expanded(flex: 1, child: CustomText(text: postfix ?? "  "))
      ],
    );
  }
}
