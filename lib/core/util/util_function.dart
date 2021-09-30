import 'dart:math';

class UtilFunction{
  static int getRandomId(){

    int random = 100 + Random().nextInt(899);
    String value =
        "${DateTime.now().year.toString().substring(2)}${DateTime.now().toString().substring(5, 7)}${DateTime.now().toString().substring(8, 10)}${DateTime.now().toString().substring(11,13)}${DateTime.now().toString().substring(14,16)}${DateTime.now().toString().substring(17,19)}$random";
    return int.parse(value);
  }

}