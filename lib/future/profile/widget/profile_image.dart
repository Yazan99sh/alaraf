import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imgSrc;

  ProfileImage({
    this.imgSrc =
        "https://organicthemes.com/demo/profile/files/2018/05/profile-pic.jpg",
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipOval(
      child: Container(
        width: size.width * 0.5,
        height: size.width * 0.5,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 15, color: Color(0xFFad62aa)),
            image: DecorationImage(
                image: NetworkImage("$imgSrc"),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
      ),
    );
  }
}
