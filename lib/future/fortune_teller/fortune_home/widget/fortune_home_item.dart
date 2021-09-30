import 'package:flutter/material.dart';
class FortuneHomeItem extends StatelessWidget {
  final String title;
  final String image;
  final bool isProfile;
  final Icon icon;
  final Function onTap;
  final bool fillWithPurple;

  const FortuneHomeItem({this.icon,this.onTap,Key key, this.title, this.image, this.isProfile = false,this.fillWithPurple = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          InkWell(
            onTap: (){
              if(onTap != null)
                onTap();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: SizedBox(),),
                Text("$title",style: TextStyle(color: Colors.white,fontFamily: "Hacen"),),
                SizedBox(width: 5,),
                Container(
                  height: size.height /12,
                  width: size.height/12,
                  decoration: isProfile ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFad62aa),width: 5),
                      image: DecorationImage(image: NetworkImage("$image"),fit: BoxFit.cover,)
                  ) : null ,
                  child: !isProfile ? icon ?? Image.asset(image,scale: 1.7,color: fillWithPurple ? Color(0xFFad62aa) : null,) : null,

                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: size.width,
            height: 1,
            color: Colors.white,
          )
        ],
      ),
    );;
  }
}
