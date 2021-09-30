import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/fortune_teller/fortuner_receive_call/view_model/expert_receive_call_view_model.dart';
import 'package:alaraf/future/user/phone_call/model/call_model.dart';
import 'package:alaraf/future/user/phone_call/page/phone_call.dart';
import 'package:alaraf/future/user/phone_call/view_model/phone_call_view_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ExpertReceiveCall extends StatefulWidget {
  final CallModel receivedCall;
  const ExpertReceiveCall({Key key, this.receivedCall}) : super(key: key);
  @override
  _ExpertReceiveCallState createState() => _ExpertReceiveCallState();
}

class _ExpertReceiveCallState extends State<ExpertReceiveCall> {
  var val;
  @override
  void initState() {
    super.initState();
    val = ExpertReceiveCallViewModel(widget.receivedCall);
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
      body: ChangeNotifierProvider<ExpertReceiveCallViewModel>.value(
        value: val,
        child: Consumer<ExpertReceiveCallViewModel>(
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
                      '${widget.receivedCall.userName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      model.timmer == '' ? '..' : model.timmer,
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
                        '${locator<AlarafApiService>().serverUrl}/image?id=${widget.receivedCall.userPicture}',
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(false)
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
                    Text(
                      '${locator<TranslateService>().selectedLanguageValue[StringKeys.str_incoming_call]}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'tus-1',
                          onPressed: () {
                            model.acceptCall();
                            //model.endToCall();
                          },
                          elevation: 20.0,
                          shape: CircleBorder(side: BorderSide(color: Colors.green)),
                          mini: false,
                          child: Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                          backgroundColor: Colors.green[100],
                        ),
                        SizedBox(width: 12,),
                        FloatingActionButton(
                          heroTag: 'tus-2',
                          onPressed: () {
                            //model.endToCall();
                          },
                          elevation: 20.0,
                          shape: CircleBorder(side: BorderSide(color: Colors.red)),
                          mini: false,
                          child: Icon(
                            Icons.call_end,
                            color: Colors.red,
                          ),
                          backgroundColor: Colors.red[100],
                        ),
                      ],
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
