import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    print(' Length :-------------->${sProviderState.songsList.length}');
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: sProviderState.songsList.length == 0 ?
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://grozip.com/image/not_found.png',),
                        fit: BoxFit.contain
                    )
                ),
              ),
              FittedBox(

                child: Container(
                  padding: EdgeInsets.only(top: 20, right: 5, left: 5),
                  child: Text(
                    "Oops! \n You Don't have any songs", style: TextStyle(
                    fontSize: 24,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
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
                '${sProviderState.songsList[index].displayName.length > 22
                    ? sProviderState.songsList[index].displayName.substring(
                    0, 20) + '...'
                    : sProviderState.songsList[index].displayName}',
              ),
              subtitle: Text('${sProviderState.songsList[index].artist}'),
            );
          },
        ),
      ),
    );
  }
}
