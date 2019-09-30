import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_view_cards/SongProvider.dart';
import 'package:provider/provider.dart';

class MyMusic extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyMusic> {
  @override
  Widget build(BuildContext context) {
    final sProviderState = Provider.of<SongProvider>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: sProviderState.songsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: sProviderState.songsList[index] == null
                        ? NetworkImage(
                            'https://www.intelli-tunes.com/ui/kvd/image/Pink360_SongArt.png')
                        : sProviderState.songsList[index].albumArtwork == null
                            ? AssetImage(
                                'images/SongArt.png')
                            : FileImage(
                                File(
                                    '${sProviderState.songsList[index].albumArtwork}'),
                              )),
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onTap: () {
              sProviderState.setCurrentSong(sProviderState.songsList[index]);
              /*play(index);*/
              sProviderState.playSong(context);
              sProviderState.settingPlayPause(true);
              sProviderState.setIsSongPlaying(true);
              sProviderState.setEqLoopAnimation(true);
            },
            //leading: Ima,
            title: Text(
              '${sProviderState.songsList[index].displayName.length > 22 ? sProviderState.songsList[index].displayName.substring(0, 20) + '...' : sProviderState.songsList[index].displayName}',
            ),
          subtitle: Text('${sProviderState.songsList[index].artist}'),
          );
        },
      ),
    );
  }
}
