import 'package:flutter/material.dart';
import 'calculator_container.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late double width;
  late List<String> number;
  late String operation;
  late double temp;

  @override
  void initState() {
    super.initState();
    number = ["0"];
    operation = "";
    temp = 0;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Hesap Makinesi"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  numberToString(number),
                  style: const TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: CalculatorContainer("AC", width / 5, width / 5,
                          Colors.grey, Colors.black),
                      onTap: () {
                        setState(() {
                          number = ["0"];
                        });
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer("+/-", width / 5, width / 5,
                          Colors.grey, Colors.black),
                      onTap: () {
                        if (number[0] == "-") {
                          setState(() {
                            number.removeAt(0);
                          });
                        } else {
                          setState(() {
                            number.insert(0, "-");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "%", width / 5, width / 5, Colors.grey, Colors.black),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                        } else {
                          double d = listStringToDouble(number) / 100;
                          setState(() {
                            number = doubleToListString(d);
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "÷",
                          width / 5,
                          width / 5,
                          operation == "divide" ? Colors.white : Colors.orange,
                          operation == "divide" ? Colors.orange : Colors.white),
                      onTap: () {
                        temp = listStringToDouble(number);
                        setState(() {
                          operation = "divide";
                          number = ["0"];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: CalculatorContainer(
                          "7", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if (((listStringToDouble(number) == 0 ||
                                    listStringToDouble(number) == -0) &&
                                !number.contains(",")) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["7"];
                          });
                        } else {
                          setState(() {
                            number.add("7");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "8", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["8"];
                          });
                        } else {
                          setState(() {
                            number.add("8");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "9", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["9"];
                          });
                        } else {
                          setState(() {
                            number.add("9");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "×",
                          width / 5,
                          width / 5,
                          operation == "multiply"
                              ? Colors.white
                              : Colors.orange,
                          operation == "multiply"
                              ? Colors.orange
                              : Colors.white),
                      onTap: () {
                        temp = listStringToDouble(number);
                        setState(() {
                          operation = "multiply";
                          number = ["0"];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: CalculatorContainer(
                          "4", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["4"];
                          });
                        } else {
                          setState(() {
                            number.add("4");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "5", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["5"];
                          });
                        } else {
                          setState(() {
                            number.add("5");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "6", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["6"];
                          });
                        } else {
                          setState(() {
                            number.add("6");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "-",
                          width / 5,
                          width / 5,
                          operation == "minus" ? Colors.white : Colors.orange,
                          operation == "minus" ? Colors.orange : Colors.white),
                      onTap: () {
                        temp = listStringToDouble(number);
                        setState(() {
                          operation = "minus";
                          number = ["0"];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: CalculatorContainer(
                          "1", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["1"];
                          });
                        } else {
                          setState(() {
                            number.add("1");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "2", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["2"];
                          });
                        } else {
                          setState(() {
                            number.add("2");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "3", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                          setState(() {
                            number = ["3"];
                          });
                        } else {
                          setState(() {
                            number.add("3");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          "+",
                          width / 5,
                          width / 5,
                          operation == "plus" ? Colors.white : Colors.orange,
                          operation == "plus" ? Colors.orange : Colors.white),
                      onTap: () {
                        temp = listStringToDouble(number);
                        setState(() {
                          operation = "plus";
                          number = ["0"];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: CalculatorContainer("0", width * 11 / 25,
                          width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if ((listStringToDouble(number) == 0 ||
                                listStringToDouble(number) == -0) &&
                            !number.contains(",")) {
                        } else {
                          setState(() {
                            number.add("0");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer(
                          ",", width / 5, width / 5, Colors.grey, Colors.white),
                      onTap: () {
                        if (!number.contains(",")) {
                          setState(() {
                            number.add(",");
                          });
                        }
                      },
                    ),
                    GestureDetector(
                      child: CalculatorContainer("=", width / 5, width / 5,
                          Colors.orange, Colors.white),
                      onTap: () {
                        switch (operation) {
                          case "plus":
                            {
                              double d = temp + listStringToDouble(number);
                              setState(() {
                                number = doubleToListString(d);
                                operation = "";
                              });
                              break;
                            }
                          case "minus":
                            {
                              double d = temp - listStringToDouble(number);
                              setState(() {
                                number = doubleToListString(d);
                                operation = "";
                              });
                              break;
                            }
                          case "multiply":
                            {
                              double d = temp * listStringToDouble(number);
                              setState(() {
                                number = doubleToListString(d);
                                operation = "";
                              });
                              break;
                            }
                          case "divide":
                            {
                              double d = temp / listStringToDouble(number);
                              setState(() {
                                number = doubleToListString(d);
                                operation = "";
                              });
                              break;
                            }
                        }
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  double listStringToDouble(List<String> list) {
    String s = "";
    for (int i = 0; i < list.length; i++) {
      s = s + list[i];
    }
    if (s.contains(",")) {
      s = s.replaceAll(",", ".");
    }
    if (s.endsWith(".")) {
      s = "${s}0";
    }
    return double.parse(s);
  }

  List<String> doubleToListString(double d) {
    String s = d.toString();
    List<String> list = [];
    s.split("").forEach((element) {
      list.add(element);
    });
    if (list.length > 1) {
      if (list[list.length - 1] == "0" && list[list.length - 2] == ".") {
        list.removeLast();
        list.removeLast();
      }
    }
    if (list.contains(".")) {
      list[list.indexOf(".")] = ",";
    }
    return list;
  }

  String numberToString(List<String> list) {
    String s = "";
    for (int i = 0; i < list.length; i++) {
      s = s + list[i];
    }
    return s;
  }
}
