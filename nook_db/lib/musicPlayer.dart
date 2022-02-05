import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';

class MusicPlayer extends StatefulWidget {
  MusicPlayer({ Key? key , required this.url}) : super(key: key);
  String url;

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer? player;
  Duration duration = Duration(seconds: 60);
  double currentPoint = 0.0;
  IconData playIcon = Icons.play_arrow;
  bool isEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    player = AudioPlayer();

    player!.setUrl(widget.url).then((value) {
      setState(() {
        duration = value!;
        isEnabled = true;
      });
      
    });

    player!.positionStream.listen((event) {
      setState(() {
        currentPoint = event.inSeconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        //ElevatedButton(onPressed: (){}, child: Icon(Icons.music_off)),
        ElevatedButton(onPressed: _playMusic , child: Icon(playIcon)),

      ],
      mainAxisAlignment: MainAxisAlignment.center,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${currentPoint.toInt()}".padLeft(3, '0')),
          Slider(
        value: currentPoint,
        onChanged: _updateMusic,
        min: 0,
        max: duration.inSeconds.toDouble(),
        
        ),
        Text("${duration.inSeconds.toString().padLeft(3, '0')}"),
      ],
      ),
      
    ], mainAxisSize: MainAxisSize.min,);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    player!.stop();
    player!.dispose();
  }

  void _playMusic()
  {
    if(!isEnabled)
    {
      return;
    }

    if(player!.playing)
    {
      player!.pause();
      setState(() {
        playIcon = Icons.play_arrow;
      });
    }
    else
    {
      player!.play();
      setState(() {
        playIcon = Icons.pause;
      });
    }
  }

  void _updateMusic(double point)
  {
    if(!isEnabled)
    {
      return;
    }

    setState(() {
      currentPoint = point;
      player!.seek(Duration(seconds: currentPoint.toInt()));
      
    });
  }
}