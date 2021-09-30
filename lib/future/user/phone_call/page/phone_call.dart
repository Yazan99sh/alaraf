import 'dart:async';

import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/user/phone_call/view_model/phone_call_view_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoiceCallPage extends StatefulWidget {
  final AlarafUser expert;

  const VoiceCallPage({Key key, this.expert}) : super(key: key);
  @override
  _VoiceCallPageState createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {

  PhoneCallViewModel val;





  @override
  void initState() {
    super.initState();
    val = PhoneCallViewModel(widget.expert.id);
  }

  @override
  void dispose() {
    if(val.timmerInstance != null && val.timmerInstance.isActive)
    val.timmerInstance.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<PhoneCallViewModel>.value(
        value: val,
        child: Consumer<PhoneCallViewModel>(
          builder: (_,model,__){
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/background.png"),
                        fit: BoxFit.cover)),
                padding: EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'VOICE CALL',
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${widget.expert.name} ${widget.expert.surname}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      model.timmer == '' ? 'Holding...' : model.timmer,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200.0),
                      child: Image.network(
                        '${locator<AlarafApiService>().serverUrl}/image?id=${widget.expert.pictureUrl}',
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FunctionalButton(
                          title: 'Speaker',
                          icon: Icons.phone_in_talk,
                          onPressed: () {},
                        ),

                        FunctionalButton(
                          title: 'Mute',
                          icon: Icons.mic_off,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        model.endToCall();
                      },
                      elevation: 20.0,
                      shape: CircleBorder(side: BorderSide(color: Colors.red)),
                      mini: false,
                      child: Icon(
                        Icons.call_end,
                        color: Colors.red,
                      ),
                      backgroundColor: Colors.red[100],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FunctionalButton extends StatefulWidget {
  final title;
  final icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Colors.deepPurpleAccent,
          fillColor: Colors.white,
          elevation: 10.0,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              widget.icon,
              size: 30.0,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 15.0, color: Colors.deepPurpleAccent),
          ),
        )
      ],
    );
  }
}