import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'dart:io';
import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:simple_permissions/simple_permissions.dart';

class ModSound extends StatefulWidget {
  @override
  _ModSoundState createState() => new _ModSoundState();
}

class _ModSoundState extends State<ModSound> {

  bool _isRecording = false;
  bool _isPlaying   = false;
  StreamSubscription _recorderSubscription;  
//  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  Permission permission;

  String _recorderTxt = '00:00:00';
  String _playerTxt   = '00:00:00';
  double _dbLevel;

  double sliderPosition = 0.0;
  double maxDuration = 1.0;

  @override
  void initState() {
    super.initState();
    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
//    flutterSound.setDbPeakLevelUpdate(0.8);
//    flutterSound.setDbLevelEnabled(true);
  }

  void startRecorder() async{
    try {
      String path = await flutterSound.startRecorder(null);
      print('startRecorder: $path');

      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);

        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      });
//      _dbPeakSubscription =
//          flutterSound.onRecorderDbPeakChanged.listen((value) {
//            print("got update -> $value");
//            setState(() {
//              this._dbLevel = value;
//            });
//          });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async{
    try {
      String result = await flutterSound.stopRecorder();
<<<<<<< HEAD
      //print('stopRecorder: $result');
      //define form data
      FormData formData = new FormData.from({
        "file": new UploadFileInfo(new File(result), "sample.mp4"),
      });
      //send backend request
      response = await dio.post("https://choirhub-staging.rmdform.com/silent/store", data: formData);
      print(response.data.toString());
=======
      print('stopRecorder: $result');
>>>>>>> parent of a4ff8e1... Update LowerCamelCase & AWS Upload

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
//      if (_dbPeakSubscription != null) {
//        _dbPeakSubscription.cancel();
//        _dbPeakSubscription = null;
//      }

      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  void startPlayer() async{
    String path = await flutterSound.startPlayer(null);
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          sliderPosition = e.currentPosition;
          maxDuration = e.duration;

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
          String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
          this.setState(() {
            this._isPlaying = true;
            this._playerTxt = txt.substring(0, 8);
          });
        }
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void stopPlayer() async{
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        this._isPlaying = false;
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async{
    String result = await flutterSound.pausePlayer();
    print('pausePlayer: $result');
  }

  void resumePlayer() async{
    String result = await flutterSound.resumePlayer();
    print('resumePlayer: $result');
  }

  void seekToPlayer(int milliSecs) async{
    int secs = Platform.isIOS ? milliSecs / 1000 : milliSecs;

    String result = await flutterSound.seekToPlayer(secs);
    print('seekToPlayer: $result');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 24.0, bottom:16.0),
                  child: Text(
                    this._recorderTxt,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                _isRecording ? LinearProgressIndicator(
                  value: 100.0 / 120.0 * (this._dbLevel ?? 1) / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.red,
                ) : Container()
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                      onPressed: () {
                        if (!this._isRecording) {
                          return this.startRecorder();
                        }
                        this.stopRecorder();
                      },
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: this._isRecording ? AssetImage('res/icons/ic_stop.png') : AssetImage('res/icons/ic_mic.png'),
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60.0, bottom:16.0),
                  child: Text(
                    this._playerTxt,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                      onPressed: () {
                        startPlayer();
                      },
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('res/icons/ic_play.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                      onPressed: () {
                        pausePlayer();
                      },
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        width: 36.0,
                        height: 36.0,
                        image: AssetImage('res/icons/ic_pause.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                      onPressed: () {
                        stopPlayer();
                      },
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        width: 28.0,
                        height: 28.0,
                        image: AssetImage('res/icons/ic_stop.png'),
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Container(
              height: 56.0,
              child: Slider(
                value: sliderPosition,
                min: 0.0,
                max: maxDuration,
                onChanged: (double value) async{
                  await flutterSound.seekToPlayer(value.toInt());
                },
                divisions: maxDuration.toInt()
              )
            )
          ],
        ),
      ),
    );
  }


  
}
