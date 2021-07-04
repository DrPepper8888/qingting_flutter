
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_flutter/model/track_detail_from_search_model.dart';
import 'dart:ui' as ui;

class TrackViewFromSearch extends StatefulWidget{
  TrackDetailFromSearchModel trackData;

  TrackViewFromSearch({Key key,this.trackData}):super(key:key);

  @override
  _TrackViewFromSearchState createState() {
    return _TrackViewFromSearchState();
  }
}

class _TrackViewFromSearchState extends State<TrackViewFromSearch>{

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: ListTile(
          // leading: Image.network('https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png'),
          leading: Icon(FontAwesomeIcons.music),
          title: Text(widget.trackData.name),
          subtitle:Text(widget.trackData.artist+'\nListner: '+widget.trackData.listeners ),
          isThreeLine: true,
          onTap: (){
            //todo 点击歌曲应该能够播放
          },
        )
    );
  }

}