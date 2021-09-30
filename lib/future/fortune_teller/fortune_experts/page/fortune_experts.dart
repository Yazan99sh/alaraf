import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/data/util_data.dart';
import 'package:alaraf/future/fortune_teller/fortune_experts/view_model/fortune_expert_view_model.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/page/fortune_home.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';

var textE =
    "عندما يريد العالم أن ‪يتكلّم ‬ ، فهو يتحدّث بلغة يونيكود. تسجّل الآن لحضور المؤتمر الدولي العاشر ليونيكود (Unicode Conference)، الذي سيعقد في 10-12 آذار 1997 بمدينة مَايِنْتْس، ألمانيا. و سيجمع المؤتمر بين خبراء من كافة قطاعات الصناعة على الشبكة العالمية انترنيت ويونيكود، حيث ستتم، على الصعيدين الدولي والمحلي على حد سواء مناقشة سبل استخدام يونكود في النظم القائمة وفيما يخص التطبيقات الحاسوبية، الخطوط ";
const SCALE_FRACTION = 0.4;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 150.0;

class FortuneExperts extends StatefulWidget {
  @override
  _FortuneExpertsState createState() => _FortuneExpertsState();
}

class _FortuneExpertsState extends State<FortuneExperts> {
  String statusText = "";
  bool isComplete = false;
  bool firstRecordSaved = false;
  VoiceMessageState state = VoiceMessageState.Idle;

  AudioPlayerState audioPlayerState = AudioPlayerState.STOPPED;
  AudioPlayer audioPlayer;
  Duration duration = new Duration();
  AudioCache audioCache;
  Duration position = new Duration();

  @override
  void initState() {
    pageController =
        PageController(initialPage: 0, viewportFraction: viewPortFraction);
    super.initState();
    //  initPlayer();
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() => position = event);

      print("Player Going ... $event");
    });
    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => duration = d);
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.COMPLETED) {
        audioPlayerState = event;
        setState(() {});
      }
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  double viewPortFraction = 0.5;

  PageController pageController;

  //1-Cup
  //2-Tarot
  //3-Palmistry
  //4-FAce
  //5-Dreams
  //6-Love Harmony
  //7-Constellation
  //8- My Soul Revealed
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var serviceList = [
      {
        "image": "assets/images/activity/cup.png",
        "title": translate[StringKeys.str_cup]
      },
      {
        "image": "assets/images/activity/tarot.png",
        "title": translate[StringKeys.str_tarot]
      },
      {
        "image": "assets/images/activity/hand.png",
        "title": translate[StringKeys.str_hand]
      },
      {
        "image": "assets/images/activity/face.png",
        "title": translate[StringKeys.str_face]
      },
      {
        "image": "assets/images/activity/dream.png",
        "title": translate[StringKeys.str_dreams]
      },
      {
        "image": "assets/images/activity/love.png",
        "title": translate[StringKeys.str_love]
      },
      {
        "image": "assets/images/activity/star.png",
        "title": translate[StringKeys.str_constellations]
      },
      {
        "image": "assets/images/activity/aura.png",
        "title": translate[StringKeys.str_spiritual]
      },
    ];

    return ChangeNotifierProvider<FortuneExpertViewModel>.value(
      value: FortuneExpertViewModel(),
      child: Consumer<FortuneExpertViewModel>(
        builder: (_, model, __) => Scaffold(
          body: AlarafBackground(
              child: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 50.0,
                              left: 10,
                            ),
                            child: Container(
                              child: TwoTypeButton(
                                title: "${translate[StringKeys.str_back]}",
                                onPressedFunc: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        //TODO will refactor DRY codes. for row sections.
                        Container(
                          height: PAGER_HEIGHT,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification notification) {
                              if (notification is ScrollUpdateNotification) {
                                model.updatePage(pageController.page);
                              }
                            },
                            child: PageView.builder(
                              onPageChanged: (pos) {
                                model.updateExpert(pos);
                              },
                              physics: BouncingScrollPhysics(),
                              controller: pageController,
                              itemCount: model.allExpert.length,
                              itemBuilder: (context, index) {
                                var expert = model.allExpert[index];
                                final scale = max(
                                    SCALE_FRACTION,
                                    (FULL_SCALE - (index - model.page).abs()) +
                                        viewPortFraction);
                                return circleOffer(expert.pictureUrl, scale);
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        if (model.selectedExpert.userStatus == 0 && locator<AlarafUser>().userType == 1)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    translate[UtilData.status[
                                        model.selectedExpert.userStatus]],
                                    style: TextStyle(
                                      fontFamily: "Hacen",
                                      fontSize: ScreenUtil().setSp(40),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TwoTypeButton(
                                      title:
                                          "${translate[model.notifyList.map((e) => e.expertId).contains(model.selectedExpert.id) ? StringKeys.str_not_notify : StringKeys.str_notify_me]}",
                                      onPressedFunc: () {
                                        model.notifyList.map((e) => e.expertId).contains(model.selectedExpert.id) ?
                                        model.removeNotify() :  model.saveNotify();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: size.width,
                          height: size.height * 0.25,
                          color: Color(0xffad62aa),
                          child: Stack(
                            //TODO change this stack.
                            children: [
                              Column(
                                children: [
                                  Text(
                                    model.selectedExpert.name,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontFamily: "Hacen",
                                      fontSize: ScreenUtil().setSp(40),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        "5.0",
                                        style: TextStyle(
                                          fontFamily: "Hacen",
                                          color: Color(0xFFedb462),
                                          fontSize: ScreenUtil().setSp(40),
                                        ),
                                      )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      for (int i = 0; i < 4; i++)
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFedb462),
                                          size: 18,
                                        )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if(model.selectedExpert.userVoiceInfoUrl != null)
                              VoiceMessage(
                                url:
                                "${model.service.serverUrl}/activity/record?id=1&isAnswer=false&path=${model.selectedExpert.userVoiceInfoUrl}",
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, left: 15.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.100,
                                    width: size.width,
                                    color: Color(0xFFad62aa),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (int item in model
                                            .selectedExpert.abilityIndex) ...[
                                          Container(
                                            width: size.width *
                                                0.8 /
                                                serviceList.length,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Image.asset(
                                                  "${serviceList[item - 1]['image']}",
                                                  color: Colors.white,
                                                )),
                                                AutoSizeText(
                                                  "${serviceList[item - 1]['title']}",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Hacen"),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item !=
                                              model.selectedExpert.abilityIndex
                                                  .last)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2,
                                                  bottom: 30),
                                              child: Center(
                                                child: Container(
                                                  width: 1,
                                                  height: size.width *
                                                      0.9 /
                                                      serviceList.length,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                        ]
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Color(0xffad62aa).withOpacity(0.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        translate[StringKeys.str_about_expert],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Hacen"),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        model.selectedExpert.aboutExpert ?? '',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontFamily: "Hacen"),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }

  Widget circleOffer(String image, double scale) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: PAGER_HEIGHT * scale,
        width: PAGER_HEIGHT * scale,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: CircleBorder(
              side: BorderSide(color: Color(0xFFad62aa), width: 5)),
          child: FadeInImage.assetNetwork(
            placeholder: '',
            image: '${locator<AlarafApiService>().serverUrl}/image?id=$image',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath;

  void play() async {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      if (audioPlayerState == AudioPlayerState.PLAYING) {
        await audioPlayer.stop();
        audioPlayerState = AudioPlayerState.STOPPED;
      } else {
        audioPlayerState = AudioPlayerState.PLAYING;
        audioPlayer
            .play(recordFilePath, isLocal: true)
            .whenComplete(() => print("Res"));
      }
      setState(() {});
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (d.existsSync()) {
      d.deleteSync(recursive: true);
    }
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    print("$i");
    return sdPath + "/test_${i++}.mp3";
  }
}
