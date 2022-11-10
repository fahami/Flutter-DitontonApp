import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  late TextTheme style;
  setUp(() {
    style = kTextTheme;
  });
  test("should have valid text style", () {
    expect(style.headline5,
        GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400));
    expect(
        style.headline6,
        GoogleFonts.poppins(
            fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15));
    expect(
        style.subtitle1,
        GoogleFonts.poppins(
            fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15));
    expect(
        style.bodyText2,
        GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25));
  });
}
