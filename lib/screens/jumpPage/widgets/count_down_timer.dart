

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:feetback/services/bluetooth_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'custom_timer_painter.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;
  final BluetoothService _bluetoothService = locator<BluetoothService>();
  bool _sended = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    int millis = duration.inMilliseconds;
    if(millis>2000) return "3";
    if(millis>1000) return "2";
    if(millis>0){
      if(!_sended){
        _bluetoothService.sendMessage("s");
        _sended=true;
      }
       return "1";    
      }
    return "GO!";
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    controller.reverse(
      from: controller.value == 0.0
      ? 1.0
      : controller.value);
    
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body:
      AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[                
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                        animation: controller,
                                        backgroundColor: Colors.white,
                                        color: Color.fromRGBO(51, 66, 91, 1),
                                      )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: Color.fromRGBO(51, 66, 91, 1),
                                            )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}