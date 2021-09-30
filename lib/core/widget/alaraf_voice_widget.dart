import 'dart:async';
import 'dart:io';

import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:record_mp3/record_mp3.dart';

enum VoiceMessageState {
  Idle,
  Recording,
  Pause,
}

class VoiceMessage extends StatefulWidget {
  @override
  _VoiceMessageState createState() => _VoiceMessageState();
  final String title;
  final Function recordSaved;
  final String url;
  final Function counter;

  const VoiceMessage(
      {Key key, this.title, this.recordSaved, this.url, this.counter})
      : super(key: key);
}

class _VoiceMessageState extends State<VoiceMessage> {
  String statusText = "";
  bool isComplete = false;
  bool firstRecordSaved = false;
  VoiceMessageState state = VoiceMessageState.Idle;

  AudioPlayerState audioPlayerState = AudioPlayerState.STOPPED;
  AudioPlayer audioPlayer;
  Duration duration = new Duration();
  AudioCache audioCache;
  Duration position = new Duration();

  Timer _timer;
  int _start = 12;

  @override
  void initState() {
    super.initState();
    //  initPlayer();
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() => position = event);
      print(
          'max -> ${duration.inMilliseconds.toDouble()} value -> ${position.inMilliseconds.toDouble()}');

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
    _start = 60 * 5;
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          stopRecord();
          stopTimer();
          state = VoiceMessageState.Idle;
          firstRecordSaved = true;
          setState(() {});
        } else {
          setState(() {
            if (widget.counter != null) widget.counter(_start);
            _start--;
          });
        }
      },
    );
  }

  stopTimer() {
    _timer.cancel();
    print(widget.counter == null);
    if (widget.counter != null) widget.counter(-1);
    setState(() {});
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  void seekToMillisecond(int milliseconds) {
    Duration newDuration = Duration(milliseconds: milliseconds);

    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (audioPlayerState != AudioPlayerState.PLAYING &&
              widget.url == null) ...[
            InkWell(
              onTap: () async {
                print("state ${state} ***");
                if (state == VoiceMessageState.Idle) {
                  state = VoiceMessageState.Recording;
                  startRecord();
                  setState(() {});
                } else if (state == VoiceMessageState.Recording) {
                  var result = await askSelection();
                  if (result) {
                    stopRecord();
                    stopTimer();
                    state = VoiceMessageState.Idle;
                    firstRecordSaved = true;
                    setState(() {});
                  } else {
                    pauseRecord();
                    stopTimer();
                    state = VoiceMessageState.Pause;
                    setState(() {});
                  }
                } else {
                  pauseRecord();
                  startTimer();
                  state = VoiceMessageState.Recording;
                  setState(() {});
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.red,
                    ),
                  ),
                  Center(
                    child: state != VoiceMessageState.Idle &&
                            state != VoiceMessageState.Pause
                        ? Icon(
                            Icons.stop,
                            size: 18,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.record_voice_over,
                            size: 18,
                            color: Colors.red,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
          if ((firstRecordSaved && state != VoiceMessageState.Recording) ||
              widget.url != null) ...[
            InkWell(
              onTap: () {
                play();
                //seekToSecond(int.parse(duration.toString()));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.red,
                    ),
                  ),
                  Center(
                    child: audioPlayerState == AudioPlayerState.PLAYING
                        ? Icon(
                            Icons.stop,
                            size: 18,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.play_arrow,
                            size: 18,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
          Expanded(
            child: Slider(
                activeColor: Colors.red,
                inactiveColor: Colors.white,
                value: position.inMilliseconds.toDouble() >
                        duration.inMilliseconds.toDouble()
                    ? duration.inMilliseconds.toDouble()
                    : position.inMilliseconds.toDouble(),
                min: 0.0,
                max: duration.inMilliseconds.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    seekToMillisecond(value.toInt());
                  });
                }),
          ),
          AutoSizeText(
            widget.title ?? "",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              fontFamily: "Hacen",
              color: Colors.white,
            ),
          ),
        ],
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
    print("Kayıt başladı");
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      startTimer();
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
        print('Recording');
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        print(' "Recording pause..."');
        setState(() {});
      }
    }
  }

  void stopRecord() {
    print('!');
    print("Kayıt durdu");
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
    widget.recordSaved(File(recordFilePath));
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
    if ((recordFilePath != null && File(recordFilePath).existsSync()) ||
        widget.url != null) {
      if (audioPlayerState == AudioPlayerState.PLAYING) {
        //Todo: Add Stop Function here
        await audioPlayer.stop();
        audioPlayerState = AudioPlayerState.STOPPED;
      } else {
        audioPlayerState = AudioPlayerState.PLAYING;
        if (widget.url == null)
          audioPlayer
              .play(recordFilePath, isLocal: true)
              .whenComplete(() => print("Res"));
        else {
          int result = await audioPlayer.play(widget.url);
          if (result == 1) {
            print("Müzik Çalışıyor");
          } else {
            print("Müzik çalamadı");
          }
        }
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

  Future<bool> askSelection() {
    var language = locator<TranslateService>().selectedLanguageValue;
    return showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(language[StringKeys.str_voice_info]),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    icon: Icon(Icons.stop),
                    label: Text(language[StringKeys.str_voice_stop])),
                TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    icon: Icon(Icons.pause),
                    label: Text(language[StringKeys.str_voice_pause])),
              ],
            ));
  }
}
