import 'package:flutter/material.dart';

class AppTheme {
  // Colores futuristas personalizados
  static const neonBlue = Color(0xFF00F0FF);
  static const neonPurple = Color(0xFF9D00FF);
  static const darkMatter = Color(0xFF1A1B2E);
  static const cyberPink = Color(0xFFFF2E6C);
  static const neonGreen = Color(0xFF39FF14);

  /// Tema claro futurista
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true, // Add here instead
    colorScheme: ColorScheme.fromSeed(
      seedColor: neonBlue,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[100],
        foregroundColor: darkMatter,
        elevation: 4,
        shadowColor: neonBlue.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: neonPurple,
        side: const BorderSide(color: neonPurple, width: 2),
      ),
    ),
  );

  /// Tema oscuro futurista
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true, // Add here instead
    colorScheme: ColorScheme.fromSeed(
      seedColor: neonPurple,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: darkMatter,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A2B3E),
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: neonPurple.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: neonBlue,
        side: const BorderSide(color: neonBlue, width: 2),
      ),
    ),
  );
}
