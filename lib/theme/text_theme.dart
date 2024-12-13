import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleStyle = GoogleFonts.orbitron(
  textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 100, 210, 224),
    letterSpacing: 4.0,
  ),
);

TextStyle nameStyle = GoogleFonts.spaceMono(
    textStyle: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));
TextStyle speciesStyle = GoogleFonts.spaceMono(
    textStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white));
TextStyle statusStyle = GoogleFonts.spaceMono(
    textStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white));
