import 'dart:ui';
class ColorReferences {
  static Color getColor(String nameColor) {
    final colorString = <String>[
      "black",
      "blue",
      "brown",
      "gray",
      "green",
      "pink",
      "purple",
      "red",
      "white",
      "yellow"
    ];

    final colorList = <Color>[
      Color.fromRGBO(64, 64, 64, 1.0),
      Color.fromRGBO(3, 164, 244, 1.0),
      Color.fromRGBO(153, 76, 0, 1.0),
      Color.fromRGBO(192, 192, 192, 1.0),
      Color.fromRGBO(0, 153, 76, 1.0),
      Color.fromRGBO(204, 0, 102, 1.0),
      Color.fromRGBO(102, 0, 102, 1.0),
      Color.fromRGBO(255, 51, 51, 1.0),
      Color.fromRGBO(204, 255, 229, 1.0),
      Color.fromRGBO(224, 242, 63, 1.0)];

    Color color = Color.fromRGBO(3, 169, 244, 1.0);
    for (int i = 0; i < colorString.length; i++) {
      if(colorString[i] == nameColor){
        color = colorList[i];
      }
    }
    return color;
  }
}
