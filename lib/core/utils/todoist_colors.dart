class TodoistColors {
  // color_utils.dart

// List of colors
  static List<int> colors = [0xffb8256f, 0xffdb4035, 0xffff9933, 0xfffad000, 0xffafb83b, 0xff7ecc49, 0xff299438, 0xff6accbc, 0xff158fad, 0xff14aaf5, 0xff96c3eb, 0xff4073ff, 0xff884dff, 0xffaf38eb, 0xffeb96eb, 0xffe05194, 0xffe05194, 0xff808080, 0xffb8b8b8, 0xffccac93];

// Mapping from color codes to names
  static Map<int, String> codeToName = {
    0xffb8256f: "berry_red",
    0xffdb4035: "red",
    0xffff9933: "orange",
    0xfffad000: "yellow",
    0xffafb83b: "olive_green",
    0xff7ecc49: "lime_green",
    0xff299438: "green",
    0xff6accbc: "mint_green",
    0xff158fad: "teal",
    0xff14aaf5: "sky_blue",
    0xff96c3eb: "light_blue",
    0xff4073ff: "blue",
    0xff884dff: "grape",
    0xffaf38eb: "violet",
    0xffeb96eb: "lavender",
    0xffe05194: "magenta",
    0xffff8d85: "salmon", // Repeated color code with a different name
    0xff808080: "charcoal",
    0xffb8b8b8: "grey",
    0xffccac93: "taupe"
  };

// Mapping from names to color codes
  static Map<String, int> nameToCode = {
    "berry_red": 0xffb8256f,
    "red": 0xffdb4035,
    "orange": 0xffff9933,
    "yellow": 0xfffad000,
    "olive_green": 0xffafb83b,
    "lime_green": 0xff7ecc49,
    "green": 0xff299438,
    "mint_green": 0xff6accbc,
    "teal": 0xff158fad,
    "sky_blue": 0xff14aaf5,
    "light_blue": 0xff96c3eb,
    "blue": 0xff4073ff,
    "grape": 0xff884dff,
    "violet": 0xffaf38eb,
    "lavender": 0xffeb96eb,
    "magenta": 0xffe05194,
    "salmon": 0xffe05194, // Repeated color name with the same code
    "charcoal": 0xff808080,
    "grey": 0xffb8b8b8,
    "taupe": 0xffccac93
  };

// Function to get color name from code
  static String getColorName(int code) {
    return codeToName[code] ?? "Unknown";
  }

// Function to get color code from name
  static int getColorCode(String name) {
    return nameToCode[name] ?? 0x00000000; // Default to black if not found
  }
}
