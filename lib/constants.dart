import 'package:bloodpressure/widgets/custom_text.dart';
import 'package:flutter/material.dart';

elevatedButton({required String text, required Function() fun}) {
  return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(text.length * 15, 40),
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      child: CustomText(
        text: text,
        size: 18,
        color: Colors.white,
      ));
}

textFormFeiled(
    {required TextEditingController cont,
    required String hint,
    required TextInputType keyboard,
    // required String matching,
    bool isPassword = false,
    TextAlign align = TextAlign.left,
    TextCapitalization? capitalization = TextCapitalization.none}) {
  return TextFormField(
    controller: cont,
    textAlign: align,
    textInputAction: TextInputAction.next,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    // inputFormatters: [
    //   FilteringTextInputFormatter.allow(
    //     RegExp(matching),
    //   ),
    // ],
    // maxLength: length,
    decoration: InputDecoration(
      hintText: hint,
      // hintStyle: TextStyle(fontSize: 16, color: Colors.black),
      fillColor: Colors.grey[200],
      // filled: true,
      errorStyle: const TextStyle(fontSize: 15),
      border: const UnderlineInputBorder(),
      // counter: Offstage(),
      // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    ),
    keyboardType: keyboard,
    obscureText: isPassword,
    autocorrect: false,
    textCapitalization: capitalization!,
    validator: (value) {
      if (value!.isEmpty) {
        return '???';
      }
      // if (hint == "Model" &&
      //     (int.parse(value) < 1970 ||
      //         int.parse(value) > DateTime.now().year)) {
      //   return "not a valid Model";
      // }
      return null;
    },
  );
}
