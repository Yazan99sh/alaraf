import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class MultiImageUpload extends StatefulWidget {
  final Function function;

  const MultiImageUpload({Key key, this.function}) : super(key: key);

  @override
  _MultiImageUploadState createState() => _MultiImageUploadState();
}

class _MultiImageUploadState extends State<MultiImageUpload> {
  List<Asset> images = <Asset>[];
  
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Img",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      widget.function(resultList);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => loadAssets(),
      child: Container(
        width: size.width / 5,
        height: size.width / 5,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
        ),
        child: images.length == 0 ? Text('T') : Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),

                  child: AssetThumb(asset: images.first, width: (size.width/5).floor(), height: (size.height/5).floor())),
            ),
            Positioned(
                right: 0,
                child: Container(
                  transform: Matrix4.translationValues(10, -20, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                    color: Colors.redAccent
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${images.length}',style: TextStyle(fontFamily: 'hacen',color: Colors.white),),
                  ),))
          ],
        ),
      ),
    );
  }
}
