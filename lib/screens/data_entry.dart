import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../constants.dart';

class DataEntry extends StatelessWidget {
  final _dateController = TextEditingController();
  final _weightController = TextEditingController();

  final _pulseController = TextEditingController();
  final _sisController = TextEditingController();

  final _diaController = TextEditingController();
  late DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                          // try {
                          date = (await showDatePicker(
                            // currentDate: DateTime.now(),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 15)),
                          ).then((value) {
                            // print(value);
                            _dateController.text = Jiffy([value]).yMMMMd;
                          }))!;

                          // if (date != null)
                          //   _dateController.text =
                          //       Jiffy([date]).yMMMMd;
                          // } catch (ex) {
                          //   print(ex);
                          // }
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
                        fun: () {
                          // Get.back();
                        })
                  ],
                ),
              ],
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
