import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  static TextStyle headline = GoogleFonts.hankenGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle title = GoogleFonts.hankenGrotesk(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle body = GoogleFonts.hankenGrotesk(
    fontSize: 16,
    color: AppColors.muted,
  );

  static TextStyle label = GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle button = GoogleFonts.hankenGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle caption = GoogleFonts.hankenGrotesk(
    fontSize: 12,
    color: AppColors.gray,
  );

  static TextStyle muted = GoogleFonts.hankenGrotesk(
    fontSize: 14,
    color: AppColors.muted,
  );

  static TextStyle link = GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.warning,
  );
}
