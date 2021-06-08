
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/model/populat_artist_model.dart';
import 'package:music_flutter/page/artist_detail.dart';
import 'dart:ui' as ui;

class ArtistView extends StatefulWidget{
  PopularArtistModel artistData;

  ArtistView({Key key,this.artistData}):super(key:key);

  @override
  _ArtistViewState createState() {
    return _ArtistViewState();
  }
}

class _ArtistViewState extends State<ArtistView>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.network(widget.artistData.image[1].text),
        title: Text(widget.artistData.name),
        subtitle: Text(widget.artistData.listeners),
        onTap: ()=>switchToArtistDetailPage(),
      )
    );
  }

  void switchToArtistDetailPage() { //跳转至movie详情界面
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (BuildContext context) =>
              ArtistDetailPage(artistData:widget.artistData) ),
    );
  }
}