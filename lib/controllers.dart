import 'dart:ui';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomOrientationControls extends StatefulWidget {
  const CustomOrientationControls({
    Key? key,
    this.iconSize = 20,
    this.fontSize = 12,
  }) : super(key: key);
  final double iconSize;
  final double fontSize;

  @override
  _CustomOrientationControlsState createState() =>
      _CustomOrientationControlsState();
}

class _CustomOrientationControlsState extends State<CustomOrientationControls> {
  double _currentSpeed = 1.0; // Default speed

  @override
  Widget build(BuildContext context) {
    FlickControlManager flickControlManager =
        Provider.of<FlickControlManager>(context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlickShowControlsAction(
              child: FlickSeekVideoAction(
                child: FlickAutoHideChild(
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  left: 15
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5,
                                      sigmaY: 5
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        if(isPortrait){
                                          Navigator.pop(context);
                                        }
                                        else{
                                          SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.portraitUp,
                                            DeviceOrientation.portraitDown,
                                          ]);
                                          flickControlManager.exitFullscreen();
                                        }
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        child : const Icon(
                                          Icons.close,
                                          color : Colors.white,
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlickPlayToggle(
                                  size: 35,
                                  padding: const EdgeInsets.all(12),
                                  color: Colors.white,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(242, 140, 129, 242),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 60,)
                          ],
                        ),
                      ),
              ),
            ),
          ),
          Positioned.fill(
            child: FlickAutoHideChild(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlickVideoProgressBar(
                      flickProgressBarSettings: FlickProgressBarSettings(
                          height: 3,
                          handleRadius: 5,
                          curveRadius: 50,
                          bufferedColor: Colors.white,
                          playedColor: const Color.fromARGB(242, 140, 129, 242),
                          padding: const EdgeInsets.symmetric(vertical: 0)),
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            FlickCurrentPosition(
                              fontSize: widget.fontSize,
                            ),
                            Text(
                              ' / ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: widget.fontSize),
                            ),
                            FlickTotalDuration(
                              fontSize: widget.fontSize,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        DropdownButton<double>(
                          value: _currentSpeed,
                          dropdownColor: Colors.black87,
                          items: [0.5, 1.0, 1.5, 2.0]
                              .map(
                                (speed) => DropdownMenuItem<double>(
                                  value: speed,
                                  child: Text(
                                    '${speed}x',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (double? newSpeed) {
                            setState(() {
                              _currentSpeed = newSpeed ?? 1.0;
                              flickControlManager.setPlaybackSpeed(_currentSpeed);
                            });
                          },
                          underline: Container(), // Removes default underline
                        ),
                        FlickFullScreenToggle(
                          size: widget.iconSize,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
