

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/model/track_detail_model.dart';
import 'package:music_flutter/network/track_detail_request.dart';
import 'package:music_flutter/model/populat_artist_model.dart';
import 'package:music_flutter/view/track_view.dart';

class ArtistDetailPage extends StatefulWidget{
  PopularArtistModel artistData;  //艺术家信息，传过来的

  ArtistDetailPage({Key key,this.artistData}):super(key: key);

  @override
  _ArtistDetailPageState createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  TrackDetailRequest _trackDetailRequest=TrackDetailRequest();
  List<TrackDetailModel> trackList=[];
  Future<String> futureTrackList;

  @override
  void initState() {
    super.initState();
    futureTrackList=getPopularList();
  }


  Future<String> getPopularList()async{
    List<TrackDetailModel> result=await _trackDetailRequest.getTrackDetailList(widget.artistData.name);
    print('获取到的列表');
    print(result);
    if (result.length == 0) {
      return 'no_result';
    }
    setState(() {
      trackList.addAll(result);
    });
    return 'have_result';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            Image.network(widget.artistData.image[1].text), //todo 需要替换，这个api已经拿不到图片了
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.artistData.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10
                    ),
                  ),
                  Text(
                      'listner:'+widget.artistData.listeners,
                    style: TextStyle(
                      fontSize: 10
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
                future: futureTrackList,
                builder:  (context, snapshot) {
                  if (snapshot.hasData) {
                    print('从data里获取数据');
                    print(snapshot.data);
                    if (snapshot.data == 'have_result') {
                      return buildTracksResultList();
                    } else {
                      return Text('No Result, Please Search Again');
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
            )
          ],
        ),
      ),
    );

  }

  Widget buildTracksResultList() {
    return Expanded(
      child: ListView.builder(
          itemCount: trackList.length,
          itemBuilder: (context,i)=>TrackView(
              trackData: trackList[i],
          )),
    );
  }
}