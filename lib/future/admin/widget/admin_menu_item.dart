import 'package:flutter/material.dart';

class AdminMenuItem extends StatelessWidget {
  final IconData icons;
  final String title;
  final Function() onTap;

  const AdminMenuItem({Key key, this.icons, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 16,),
              Icon(icons,color: Color(0xFFD9DBE0),),
              SizedBox(width: 8,),
              Text('$title',style: TextStyle(color: Color(0xFFD9DBE0)),)
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
