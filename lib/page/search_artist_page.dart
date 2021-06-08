

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_flutter/model/populat_artist_model.dart';
import 'package:music_flutter/network/search_artist_request.dart';
import 'package:music_flutter/page/search_page.dart';
import 'package:music_flutter/view/artist_view.dart';

class SearchArtistPage extends StatefulWidget{
  String searchWords='';

  SearchArtistPage({Key key,this.searchWords}):super(key:key);

  @override
  _SearchArtistPageState createState() => _SearchArtistPageState();
}

class _SearchArtistPageState extends State<SearchArtistPage>{
  String newSearchWords='';
  Future<String> futureArtistResultList;
  SearchArtistRequest _searchArtistRequest=SearchArtistRequest();
  List<PopularArtistModel> artistResultList=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureArtistResultList=getSearchArtistResultList();
  }

  Future<String> getSearchArtistResultList()async{ //这里希望搜索了之后才会显示
    List<PopularArtistModel> result=await _searchArtistRequest.getSearchArtistResultList(widget.searchWords);
    print('获取到的列表');
    print(result);
    if (result.length == 0) {
      return 'no_result';
    }
    setState(() {
      artistResultList.addAll(result);
    });
    return 'have_result';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSearchBar(),
        if (widget.searchWords!=null) Expanded(  //有搜索词再加载
            child: FutureBuilder(
              future: futureArtistResultList,
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
        )
      ],
    );
  }

  buildArtistResultList() {
    return ListView.builder(
        itemCount: artistResultList.length,
        itemBuilder: (context,i)=>ArtistView(
            artistData:artistResultList[i]
        )
    );
  }


  Widget getSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {
                      newSearchWords = txt;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by the artist name',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  switchToSearchPage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                        size: 20,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  switchToSearchPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (BuildContext context) =>
              SearchPage(searchWords: newSearchWords,)),
    );
  }

}