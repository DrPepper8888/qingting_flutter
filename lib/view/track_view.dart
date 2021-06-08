
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
        child: ListTile(
          leading: Image.network(widget.trackData.image[1].text),
          title: Text(widget.trackData.name),
          subtitle: Text(widget.trackData.listeners),
          onTap: (){
              //todo 点击歌曲应该能够播放
          },
        )
    );
  }

}