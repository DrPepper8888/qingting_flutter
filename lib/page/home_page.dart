
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/model/populat_artist_model.dart';
import 'package:music_flutter/network/populat_artists_request.dart';
import 'package:music_flutter/page/search_page.dart';
import 'package:music_flutter/view/artist_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_flutter/page/artist_detail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String title='轻听';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PopularArtistModel> artistsList=[];
  Future<String> futureList;
  PopularArtistsRequest _popularArtistsRequest = PopularArtistsRequest();

  @override
  void initState() {
    super.initState();
    futureList=getPopularList();
  }

  Future<String> getPopularList()async{
    List<PopularArtistModel> result=await  _popularArtistsRequest.getPopularArtistsList() as List<PopularArtistModel>;
    print('获取到的列表');
    print(result);
    if (result.length == 0) {
      return 'no_result';
    }
    setState(() {
      artistsList.addAll(result);
    });
    return 'have_result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 20),
              child: InkWell(
                  child: Icon(FontAwesomeIcons.search),
                  onTap: ()=>switchToSearchPage()
              )
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: futureList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('从data里获取数据');
                  print(snapshot.data);
                  if (snapshot.data == 'have_result') {
                    return Expanded(child: buildArtistResultList());
                  } else {
                    return Text('No Result, Please Search Again');
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildArtistResultList() {
    return ListView.builder(
        itemCount: artistsList.length,
        itemBuilder: (context,i)=>ArtistView(
          artistData:artistsList[i]
        ));
  }

  switchToSearchPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (BuildContext context) =>
      SearchPage()),
    );
  }
}