import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
Widget bottomPicker(int _selectedItemIndex, List<String> allItem, Function onChange,context){
  final scrollController =
  FixedExtentScrollController(initialItem: _selectedItemIndex);
  return Container(
    color: Colors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context,true);
        },
        child: SafeArea(
          child: Stack(
            children: [
              CupertinoPicker(

                scrollController: scrollController,

                itemExtent: 30,
                backgroundColor: CupertinoColors.white,
                onSelectedItemChanged: (index) {
                  onChange(index);
                },
                children: List<Widget>.generate(allItem.length, (index) =>
                    Center(child:
                    Text(allItem[index]),
                    )),
              ),
              Positioned(
                top: 10,

                right: 10,

                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.circle
                    ),
                    child:InkResponse(
                        onTap: ()=>Navigator.pop(context,true),
                        child: Icon(Icons.close)),),
              ),
            ],
          )
        ),
      ),
    ),
  );
}