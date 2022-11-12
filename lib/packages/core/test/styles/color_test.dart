import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ColorScheme colorScheme;
  setUp(() {
    colorScheme = kColorScheme;
  });
  test("should have valid color scheme", () {
    expect(colorScheme.primary, kMikadoYellow);
    expect(colorScheme.secondary, kPrussianBlue);
    expect(colorScheme.surface, kRichBlack);
    expect(colorScheme.background, kRichBlack);
    expect(colorScheme.error, Colors.red);
    expect(colorScheme.onPrimary, kRichBlack);
    expect(colorScheme.onSecondary, Colors.white);
    expect(colorScheme.onSurface, Colors.white);
    expect(colorScheme.onBackground, Colors.white);
    expect(colorScheme.onError, Colors.white);
    expect(colorScheme.brightness, Brightness.dark);
  });
}
