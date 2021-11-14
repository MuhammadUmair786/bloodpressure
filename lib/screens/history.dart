import 'dart:convert';

import 'package:bloodpressure/model/bloodpressure_model.dart';
// import 'package:bloodpressure/save_file.dart';
import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:jiffy/jiffy.dart';

import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import '../constants.dart';

class History extends StatefulWidget {
  final String memberID;
  // final _dateController = TextEditingController();
  // final _weightController = TextEditingController();

  // final _pulseController = TextEditingController();
  // final _sisController = TextEditingController();

  // final _diaController = TextEditingController();

  History({required this.memberID});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<BloodPressureModel> recordList = [];

  final _startDateController = TextEditingController();

  final _finalDateController = TextEditingController();

  getData() async {
    String apiUrl =
        "https://bloodas.herokuapp.com/v1/information/${widget.memberID}";
    var response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> responseJSON = jsonDecode(response.body);
    // responseJSON['data']['member'][0]);
    var tempList = responseJSON['data']['bloodPressureList'];
    setState(() {
      for (var item in tempList) {
        recordList.add(BloodPressureModel.fromJson(item));
      }
      // print(recordList[0].memberId);
    });
  }

  filterList() {
    if (_startDateController.text.isNotEmpty &&
        _finalDateController.text.isNotEmpty) {
      // recordList.removeWhere(
      //     (element) => element.date.compareTo(_startDateController.text));
    }
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  // late DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const CustomText(
                  text: "Historial",
                  size: 25,
                  weight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Expanded(
                      child: userDataRecordItem(
                        "Peso kg.",
                        _startDateController,
                        "ej: 68.6",
                        TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: userDataRecordItem(
                        "Altura mt",
                        // _heightController,
                        _finalDateController,
                        "ej: 1.79",
                        TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Table(
                  // defaultColumnWidth: const FixedColumnWidth(120.0),
                  // border: TableBorder.all(
                  //     color: Colors.black, style: BorderStyle.solid, width: 2),
                  children: [
                    TableRow(
                        decoration: const BoxDecoration(color: Colors.blue),
                        children: [
                          // TableCell(
                          //     child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children:
                          //   [
                          Column(children: const [Text("SIS mmHG")]),
                          Column(children: const [Text("DIA mmHG")]),
                          Column(children: const [Text("Pulso")]),
                          Column(children: const [Text("Peso")]),
                          Column(children: const [Text("Fecha")]),
                          //   ],
                          // )

                          // )
                          // Text("SIS mmHG"),
                          // Text("DIA mmHG"),
                          // Text("Pulso"),
                          // Text("Peso"),
                          // Text("Fecha")
                          // Column(children: const [Text("SIS mmHG")]),
                          // Column(children: const [Text("DIA mmHG")]),
                          // Column(children: const [Text("Pulso")]),
                          // Column(children: const [Text("Peso")]),
                          // Column(children: const [Text("Fecha")]),
                        ]),
                  ],
                ),
                if (recordList.isNotEmpty)
                  Table(
                      // border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        for (var item in recordList)
                          TableRow(children: [
                            // TableCell(
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceAround,
                            //     children: <Widget>[
                            // new Text('VideoId'),
                            // new Text(video.id.toString()),
                            Text(item.sis),
                            Text(item.dia),
                            Text(item.pulso),
                            Text(item.peso),
                            Text(item.date),
                            //     ],
                            //   ),
                            // )
                          ])
                      ]),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.blue,
                  child: const CustomText(
                    text: "Historial",
                    size: 14,
                    color: Colors.white,
                    weight: FontWeight.w500,
                  ),
                ),
                Table(
                  // defaultColumnWidth: const FixedColumnWidth(120.0),
                  // border: TableBorder.,
                  children: [
                    TableRow(children: [
                      Column(children: const [Text("")]),
                      Column(children: const [Text("Promedio")]),
                      Column(children: const [Text("Mas Baja")]),
                      Column(children: const [Text("Mas Alta")]),
                      Column(children: const [Text("Desviacion")]),
                    ]),
                    TableRow(children: [
                      Column(children: const [Text("SIS")]),
                      Column(children: const [Text("-")]),
                      Column(children: const [Text("-")]),
                      Column(children: const [Text("-")]),
                      Column(children: const [Text("-")]),
                    ]),
                    TableRow(children: [
                      Column(children: const [Text("DIA")]),
                      Column(children: const [Text("-")]),
                      Column(children: const [Text("-")]),
                      Column(children: const [Text("-")]),
                      Column(children: const [Text("-")]),
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    elevatedButton(
                        text: "VOLVER",
                        fun: () {
                          Get.back();
                        }),
                    elevatedButton(
                        text: "IMPRIMIR",
                        fun: () {
                          // Get.back();
                          String printString = "";
                          for (var item in recordList) {
                            printString += item.toJson().toString();
                          }
                          // print(printString);
                          // saveTextFile(printString,
                          //     Jiffy(DateTime.now()).format("dd/MM/yyy"));
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

  Widget userDataRecordItem(
    String heading,
    TextEditingController controller,
    String hint,
    TextInputType input,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // width: double.infinity,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: heading,
            size: 16,
            weight: FontWeight.w500,
          ),
          // Expanded(
          //   // width: Get.width / 1.8,
          //   child: textFormFeiled(
          //     cont: controller,
          //     hint: hint,
          //     keyboard: input,
          //   ),
          // ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                try {
                  DateTime tempDate = (await showDatePicker(
                    // currentDate: DateTime.now(),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1947),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    controller.text = Jiffy(value).format("dd/MM/yyy");
                    filterList();
                  }))!;
                } catch (ex) {
                  print(ex);
                }
              },
              child: AbsorbPointer(
                child: Container(
                  width: Get.width / 1.8,
                  child: textFormFeiled(
                    cont: controller,
                    hint: "dd-mm-aa",
                    keyboard: TextInputType.number,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
