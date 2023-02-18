import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Convert a number to Human readable format (e.g. 1.5k, 5m, 1b)
String formattedNumber(dynamic numberToFormat) {
  if (double.parse(numberToFormat.toString()) < 1000) {
    return numberToFormat.toString();
  }
  var _formattedNumber = NumberFormat.compactCurrency(
    decimalDigits: 2,
    symbol:
        '', // if you want to add currency symbol then pass that in this else leave it empty.
  ).format(numberToFormat);
  return _formattedNumber;
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

extension MapExtension on Map? {
  bool get isNullOrEmpty => (this == null || this!.isEmpty);
}

extension IterableExtension on Iterable? {
  bool get isNullOrEmpty => (this == null || this!.isEmpty);
}

extension StringExtension on String? {
  bool get isNullOrEmpty => (this == null || this!.isEmpty);
}

extension OptionsExtension on Options? {
  bool get isNullOrEmpty => (this == null);
}
