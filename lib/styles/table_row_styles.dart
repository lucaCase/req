import 'package:flutter/material.dart';

const iBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black12, width: 0),
  borderRadius: BorderRadius.zero,
);

const textStyle = TextStyle(fontSize: 14);

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    isDense: true,
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.black54),
    border: iBorder,
    focusedBorder: iBorder,
    enabledBorder: iBorder,
  );
}

const borderSide = BorderSide(color: Colors.black12, width: 0);
