import 'package:flutter/material.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';

MaterialButton longButtons(String title, Function fun,
    {Color color: const Color(0xfff063057), Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration([String labelText, IconData icon]) {
  return InputDecoration(
    // prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,

    labelText: labelText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: HexColor('#e8e8e8'))),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: HexColor('#64feab'), width: 2.0),
    ),
  );
}
