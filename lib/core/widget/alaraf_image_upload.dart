import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final Function onChanged;
  final int multiplier;

  const ImageUpload({Key key, this.onChanged,this.multiplier = 5}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File file;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
       var result =  await showCupertinoModalPopup(context: context, builder: (c){
         return CupertinoActionSheet(
           title: Text("Cupertino Action Sheet"),
           message: Text("Select any action "),
           actions: <Widget>[
             CupertinoActionSheetAction(
               child: Text("Camera"),
               isDefaultAction: true,
               onPressed: () {
                 Navigator.pop(context,ImageSource.camera);
               },
             ),
             CupertinoActionSheetAction(
               child: Text("Gallery"),
               isDestructiveAction: true,
               onPressed: () {
                 Navigator.pop(context,ImageSource.gallery);
               },
             )
           ],
         );
       });
       if(result != null){
         final pickedFile =
         await picker.getImage(source: result);

         setState(() {
           if (pickedFile != null) {
             file = File(pickedFile.path);
             if (widget.onChanged != null) widget.onChanged(file);
           } else {
             print('No image selected.');
           }
         });
       }


      },
      child: Container(
        width: size.width / widget.multiplier,
        height: size.width / widget.multiplier,
        decoration: BoxDecoration(
            image: file == null
                ? null
                : DecorationImage(
                    image: FileImage(file), fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
        child: file != null
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  alignment: Alignment.bottomRight,
                  color: Colors.white.withOpacity(0.7),
                  padding: EdgeInsets.all(4),
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    file = null;
                    if (widget.onChanged != null)
                      widget.onChanged(file);
                    setState(() {});
                  },
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
