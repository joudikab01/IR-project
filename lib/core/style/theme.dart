import "package:flutter/material.dart";

import "assets/fonts.gen.dart";

class MaterialTheme {
  const MaterialTheme();

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      textTheme: TextTheme(
        /// Display
        displayLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 57,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 45,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 36,
        ),

        ///Headline
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),

        /// Title
        titleLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),

        /// Label
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),

        /// Body
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
      brightness: Brightness.light,
      primary: Color(0xff2B74E2),
      surfaceTint: Color(0xff445e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd8e2ff),
      onPrimaryContainer: Color(0xff001a41),
      secondary: Color(0xff00894B),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb1f1c1),
      onSecondaryContainer: Color(0xff00210e),
      tertiary: Color(0xffFCBC08),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdea1),
      onTertiaryContainer: Color(0xff261900),
      error: Color(0xffDC3A2D),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad5),
      onErrorContainer: Color(0xff3b0906),
      background: Color(0xffffffff),
      onBackground: Color(0xff1a1b20),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      surfaceVariant: Color(0xffe1e2ec),
      onSurfaceVariant: Color(0xff44474f),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      onInverseSurface: Color(0xfff0f0f7),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffb1f1c1),
      onSecondaryFixed: Color(0xff00210e),
      secondaryFixedDim: Color(0xff96d5a6),
      onSecondaryFixedVariant: Color(0xff12512e),
      tertiaryFixed: Color(0xffffdea1),
      onTertiaryFixed: Color(0xff261900),
      tertiaryFixedDim: Color(0xffeac16c),
      onTertiaryFixedVariant: Color(0xff5c4300),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      textTheme: TextTheme(
        /// Display
        displayLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 57,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 45,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 36,
        ),

        ///Headline
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),

        /// Title
        titleLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),

        /// Label
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),

        /// Body
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff102f60),
      primaryContainer: Color(0xff2b4678),
      onPrimaryContainer: Color(0xffd8e2ff),
      secondary: Color(0xff96d5a6),
      onSecondary: Color(0xff00391c),
      secondaryContainer: Color(0xff12512e),
      onSecondaryContainer: Color(0xffb1f1c1),
      tertiary: Color(0xffeac16c),
      onTertiary: Color(0xff402d00),
      tertiaryContainer: Color(0xff5c4300),
      onTertiaryContainer: Color(0xffffdea1),
      error: Color(0xffffb4a9),
      onError: Color(0xff561e18),
      errorContainer: Color(0xff73342c),
      onErrorContainer: Color(0xffffdad5),
      background: Color(0xff111318),
      onBackground: Color(0xffe2e2e9),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      surfaceVariant: Color(0xff44474f),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      onInverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xff445e91),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffb1f1c1),
      onSecondaryFixed: Color(0xff00210e),
      secondaryFixedDim: Color(0xff96d5a6),
      onSecondaryFixedVariant: Color(0xff12512e),
      tertiaryFixed: Color(0xffffdea1),
      onTertiaryFixed: Color(0xff261900),
      tertiaryFixedDim: Color(0xffeac16c),
      onTertiaryFixedVariant: Color(0xff5c4300),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(MaterialScheme colorScheme) => ThemeData(
        fontFamily: FontFamily.productSans,
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        dividerTheme: DividerThemeData(
          color: colorScheme.outlineVariant,
        ),
        tabBarTheme: TabBarTheme(
          dividerColor: colorScheme.outlineVariant,
          indicatorColor: colorScheme.primary,
          dividerHeight: 1,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: colorScheme.textTheme.labelLarge,
          unselectedLabelStyle: colorScheme.textTheme.labelLarge,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.outline,
        ),
        // inputDecorationTheme: InputDecorationTheme(
        //   labelStyle: colorScheme.textTheme.bodySmall?.copyWith(
        //     color: colorScheme.onSurfaceVariant,
        //   ),
        //   fillColor: colorScheme.surfaceContainerHighest,
        //   filled: true,
        //   border: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //       color: colorScheme.onSurfaceVariant,
        //     ),
        //   ),
        // ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: colorScheme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          floatingLabelStyle: colorScheme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.primary,
          ),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        textTheme: colorScheme.textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
          fontFamily: FontFamily.productSans,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      )..addOwn(
          OwnThemeFields(
            surfaceContainer: colorScheme.surfaceContainer,
            surfaceContainerLow: colorScheme.surfaceContainerLow,
            surfaceContainerHigh: colorScheme.surfaceContainerHigh,
            primaryFixedDim: colorScheme.primaryFixedDim,
            elevation1: [
              const BoxShadow(
                color: Color(0x26000000),
                blurRadius: 3,
                offset: Offset(0, 1),
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
            elevation2: [
              const BoxShadow(
                color: Color(0x26000000),
                blurRadius: 6,
                offset: Offset(0, 2),
                spreadRadius: 2,
              ),
              const BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
            elevation3: [
              const BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 3,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
              const BoxShadow(
                color: Color(0x26000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 3,
              )
            ],
            elevation4: [
              const BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 3,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
              const BoxShadow(
                color: Color(0x26000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 4,
              )
            ],
            elevation5: [
              const BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
              const BoxShadow(
                color: Color(0x26000000),
                blurRadius: 12,
                offset: Offset(0, 8),
                spreadRadius: 6,
              ),
            ],
          ),
        );
}

class MaterialScheme extends ColorScheme {
  const MaterialScheme({
    required super.brightness,
    required super.primary,
    required super.surfaceTint,
    required super.onPrimary,
    required super.primaryContainer,
    required super.onPrimaryContainer,
    required super.secondary,
    required super.onSecondary,
    required super.secondaryContainer,
    required super.onSecondaryContainer,
    required super.tertiary,
    required super.onTertiary,
    required super.tertiaryContainer,
    required super.onTertiaryContainer,
    required super.error,
    required super.onError,
    required super.errorContainer,
    required super.onErrorContainer,
    required super.background,
    required super.onBackground,
    required super.surface,
    required super.onSurface,
    required super.surfaceVariant,
    required super.onSurfaceVariant,
    required super.outline,
    required super.outlineVariant,
    required super.shadow,
    required super.scrim,
    required super.inverseSurface,
    required super.inversePrimary,
    required super.onInverseSurface,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.textTheme,
  });
  final TextTheme textTheme;

  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class OwnThemeFields {
  final List<BoxShadow> elevation1;
  final List<BoxShadow> elevation2;
  final List<BoxShadow> elevation3;
  final List<BoxShadow> elevation4;
  final List<BoxShadow> elevation5;
  final Color surfaceContainer;
  final Color surfaceContainerLow;
  final Color surfaceContainerHigh;
  final Color primaryFixedDim;

  const OwnThemeFields({
    required this.elevation1,
    required this.elevation2,
    required this.elevation3,
    required this.elevation4,
    required this.elevation5,
    required this.surfaceContainer,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
    required this.primaryFixedDim,
  });
}

extension ThemeDataExtensions on ThemeData {
  static final Map<InputDecorationTheme, OwnThemeFields> _own = {};

  void addOwn(OwnThemeFields own) {
    _own[inputDecorationTheme] = own;
  }

  OwnThemeFields own() {
    var o = _own[inputDecorationTheme];
    return o!;
  }
}

OwnThemeFields ownTheme(BuildContext context) => Theme.of(context).own();
