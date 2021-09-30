import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Segmented extends StatefulWidget {
  @override
  _SegmentedState createState() => _SegmentedState();
  final String optionOne;
  final String optionTwo;
  final Function onChanged;

  const Segmented(
      {Key key,
      @required this.optionOne,
      @required this.optionTwo,
      @required this.onChanged})
      : super(key: key);
}

class _SegmentedState extends State<Segmented> {
  int selection = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  selection = 0;
                  widget.onChanged(selection);
                  setState(() {});
                },
                child: Container(
                  height: 32,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color:
                        selection == 0 ? Colors.amber : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      "${widget.optionOne}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: selection == 1
                            ? Color(0xFF36569d)
                            : Color(0xffad62aa),
                        fontSize: ScreenUtil().setSp(32),
                        fontFamily: "Hacen",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 2,
                  width: 2,
                  color: Colors.amber,
                ),
                Container(
                  width: 2,
                  height: 28,
                  color: Color(0xffad62aa),
                ),
                Container(
                  height: 2,
                  width: 2,
                  color: Colors.amber,
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  selection = 1;
                  widget.onChanged(selection);
                  setState(() {});
                },
                child: Container(
                  height: 32,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color:
                        selection == 1 ? Colors.amber : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      "${widget.optionTwo}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: selection == 1
                            ? Color(0xFF36569d)
                            : Color(0xffad62aa),
                        fontSize: ScreenUtil().setSp(32),
                        fontFamily: "Hacen",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
