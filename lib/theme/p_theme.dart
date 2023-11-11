import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PTheme {
  PTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
