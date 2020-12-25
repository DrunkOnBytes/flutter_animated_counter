import 'package:flutter/material.dart';

class PixelCounter{
  PixelCounter({int initialCounter}){
    _counter = initialCounter;
  }
  List numberOfBlocks = List();
  int _counter;
  final yellowish = Color(0xffFFE45E);

  void incrementCounter(){
    _counter++;
  }
  void decrementCounter(){
    _counter++;
  }
  int getCounter(){
    return _counter;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          for (int i = 0; i < _counter.toString().length; i++)
            Expanded(
                flex: _counter.toString().length > 5 ? 1 : 0,
                child: blocks(_counter.toString()[i]))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget blocks(digit) {
    int x = int.parse(digit);
    List kaza = _numberBlocks(x);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 190,
        height: 400,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 4),
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 10,
              offset: Offset(30, 0),
            )
          ],
        ),
        child: GridView(
          children: [
            for (var index = 0; index < 15; index++)
              AnimatedContainer(
                duration: Duration(milliseconds: index * 140),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: kaza.contains(index) ? Colors.black : yellowish,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 1,
                      color: Colors.black,
                    ),
                  ],
                  border: Border.all(
                    color: kaza.contains(index) ? yellowish : Colors.black,
                    width: 0.3,
                    style: BorderStyle.solid,
                  ),
                ),
              )
          ],
          addAutomaticKeepAlives: false,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        ),
      ),
    );
  }

  _numberBlocks(int digit) {
    numberOfBlocks.clear();
    switch (digit) {
      case 0:
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 8, 9, 11, 12, 13, 14]);
        break;
      case 1:
        numberOfBlocks.addAll([1, 4, 7, 10, 13]);
        break;
      case 2:
        numberOfBlocks.addAll([0, 1, 2, 5, 6, 7, 8, 9, 12, 13, 14]);
        break;
      case 3:
        numberOfBlocks.addAll([0, 1, 2, 5, 6, 7, 8, 11, 12, 13, 14]);
        break;
      case 4:
        numberOfBlocks.addAll([0, 3, 5, 6, 7, 8, 11, 14]);
        break;
      case 5:
        numberOfBlocks.addAll([0, 1, 2, 3, 6, 7, 8, 11, 12, 13, 14]);
        break;
      case 6:
        numberOfBlocks.addAll([0, 1, 2, 3, 6, 7, 8, 9, 11, 12, 13, 14]);
        break;
      case 7:
        numberOfBlocks.addAll([0, 1, 2, 5, 8, 11, 14]);
        break;
      case 8:
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14]);
        break;
      case 9:
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 7, 8, 11, 14]);
        break;
      default:
    }
    return numberOfBlocks;
  }
}