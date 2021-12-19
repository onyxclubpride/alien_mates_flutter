import 'template.dart';

class ThemeAdditional {
  static const blueGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      ThemeColors.blueGradient_e,
      ThemeColors.blueGradient_s,
    ],
  );
  static const blueGradientReverse = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ThemeColors.blueGradient_e,
      ThemeColors.blueGradient_s,
    ],
  );

  static const blueLogo = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      ThemeColors.blueGradient_e,
      ThemeColors.blueGradient_s_2,
    ],
  );

  static const blueCoolGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      ThemeColors.blueGradient_e_3,
      ThemeColors.blueGradient_s_3,
    ],
  );

  static const redGradient = LinearGradient(
    colors: [
      ThemeColors.red,
    ],
  );

  static List<BoxShadow> dropShadow1 = [
    BoxShadow(
        offset: const Offset(0, -2),
        blurRadius: 10,
        spreadRadius: 0,
        color: ThemeColors.blueGradient_s.withOpacity(0.102))
  ];
  static List<BoxShadow> dropShadow2Fab = [
    BoxShadow(
        offset: const Offset(0, 3),
        blurRadius: 10,
        spreadRadius: 0,
        color: ThemeColors.blueGradient_s.withOpacity(0.302))
  ];

  static List<BoxShadow> innerShadow = [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 1,
      color: ThemeColors.blueGradient_s.withOpacity(0.25),
    ),
    BoxShadow(
      offset: const Offset(0, 0),
      blurRadius: 1,
      color: ThemeColors.blueGradient_s.withOpacity(0.25),
    ),
  ];

  static List<BoxShadow> frameShadow = [
    BoxShadow(
      offset: const Offset(1, 1),
      blurRadius: 2,
      color: ThemeColors.black.withOpacity(0.15),
    ),
    BoxShadow(
      offset: const Offset(0, 0),
      blurRadius: 1,
      color: ThemeColors.black.withOpacity(0.25),
    ),
  ];
}
