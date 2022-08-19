import 'package:flutter/material.dart';

class CalculatorContainer extends StatelessWidget {
  final String symbol;
  final double width;
  final double height;
  final Color containerColor;
  final Color textColor;
  const CalculatorContainer(
      this.symbol, this.width, this.height, this.containerColor, this.textColor,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 30,
            color: textColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
