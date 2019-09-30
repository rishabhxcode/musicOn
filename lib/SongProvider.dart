import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

class SongProvider with ChangeNotifier{
  SongProvider();
  List<SongInfo> songsList;

  /*Setter for Songs List*/
  void setSongsList(List<SongInfo> myDeviceSongsList){
    songsList = myDeviceSongsList;
    notifyListeners();
  }
/*Getter For Song List*/
  List<SongInfo> get getSongs =>songsList;

  /*Setter for Current Song*/
  SongInfo currSong;
  void setCurrentSong(SongInfo myCurrsong){
    currSong = myCurrsong;
    notifyListeners();
  }
  /*Getter for Current Song*/
  SongInfo get getCurrentSong=>currSong;


  /**Play Pause Flag system**/
  bool isPlaying = false;

  void setIsSongPlaying(bool value){
    isPlaying = value;
    notifyListeners();
  }
/**for EqLoop Animation*/
  String eqLoopAnimation;
  String get geteqLoopAnimation=> eqLoopAnimation;

  void setEqLoopAnimation(bool value){
    if(value == true){
      eqLoopAnimation = 'startloop';
      notifyListeners();
    }else if(value==false){
      eqLoopAnimation ='stop';
      notifyListeners();
    }
  }

  /**Ends*/
  /**for Play and Pause Animation*/

  String playpauseAnimation;

  String get getPlayPause=>playpauseAnimation;

  void settingPlayPause(bool value){
    if(value == true){
      playpauseAnimation = 'play to pause';
      notifyListeners();
    }else if(value==false){
      playpauseAnimation ='pause to play';
      notifyListeners();
    }
  }



  /**end**/
  bool get getIsSongPlaying => isPlaying;
  AudioPlayer player = AudioPlayer();

playSong(BuildContext context){
  final appState = Provider.of<SongProvider>(context);
  if(appState.getIsSongPlaying==false){
    appState.setIsSongPlaying(true);
    player.play(appState.getCurrentSong.filePath);

  }else if(appState.isPlaying==true){
    player.stop();
    player.play(appState.getCurrentSong.filePath);
  }
}

stopSong(BuildContext context)async{
  final appState = Provider.of<SongProvider>(context);
  if(appState.getIsSongPlaying==true){
    player.pause();
    appState.setIsSongPlaying(false);
  }
}

}

