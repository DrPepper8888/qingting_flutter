
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/model/track_detail_model.dart';
import 'dart:ui' as ui;

class TrackView extends StatefulWidget{
  TrackDetailModel trackData;

  TrackView({Key key,this.trackData}):super(key:key);

  @override
  _TrackViewState createState() {
    return _TrackViewState();
  }
}

class _TrackViewState extends State<TrackView>{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
        child: ListTile(
          leading: Image.network('https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png'),
          title: Text(widget.trackData.name),
          subtitle: Text('Listener: '+widget.trackData.listeners),
          onTap: (){
              //todo 点击歌曲应该能够播放
          },
        )
    );
  }

}