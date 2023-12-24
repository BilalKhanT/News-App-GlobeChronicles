import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/profile.dart';
import '../api/api_service.dart';
import '../model/news_model.dart';
import '../utils/images.dart';
import 'bookmark.dart';
import 'home.dart';

class SearchScreen extends StatefulWidget {
  String username;
  int flag;
  String query;
  SearchScreen({required this.username, required this.flag, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  late Future news;
  var searchController = TextEditingController();
  final List<String> tabs = [
    "World News",
    "Health",
    "Sports",
    "Technology",
    "Science",
    "Politics",
    "Entertainment",
    "Business",
  ];

  @override
  void initState() {
    news = getNews(widget.flag, widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(username: widget.username)));
                          },
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: () {
                          },
                          icon: Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookMarkScreen(username: widget.username)));
                          },
                          icon: Icon(
                            Icons.star_border_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: ()  {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: widget.username)));
                          },
                          icon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: news,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData){
              List<NewsModel> newsList = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Discover',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'News all around the globe',
                      style: GoogleFonts.poppins(
                        color: Color(0xffB81736),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      width: screenWidth - 50,
                      child: GestureDetector(
                        child: TextField(
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if ((value).replaceAll(" ", "") == "") {
                              print("Blank");
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            suffixIcon: Icon(
                              Icons.tune,
                              color: Color(0xffB81736),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xffB81736),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search for news",
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.black26
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tabs.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                if (index == 0){
                                  news = getNews(0, '',);
                                }
                                else if (index == 1){
                                  news = getNews(1, 'health');
                                }
                                else if (index == 2){
                                  news = getNews(1, 'sports');
                                }
                                else if (index == 3){
                                  news = getNews(1, 'technology');
                                }
                                else if (index == 4){
                                  news = getNews(1, 'science');
                                }
                                else if (index == 5){
                                  news = getNews(1, 'politics');
                                }
                                else if (index == 6){
                                  news = getNews(1, 'entertainment');
                                }
                                else if (index == 7){
                                  news = getNews(1, 'business');
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(tabs[index], style:
                              GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                              ),),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: newsList.length - 1,
                        itemBuilder: (context, index){
                          try{
                            return Row(
                            children: [
                              Container(
                                height: 85,
                                width: 80,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: newsList[index].newsImg,
                                  errorWidget: (context, url, error) => Image.asset(AssetImages.appLogo) ,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      newsList[index].newsTitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, color: Color(0xffB81736),),
                                        const SizedBox(width: 5),
                                        Text(newsList[index].newsDate.substring(0, 10),
                                        style: GoogleFonts.poppins(
                                          color: Colors.black54
                                        ),),
                                        const SizedBox(width: 20),
                                        Icon(Icons.person_outline_outlined, color: Color(0xffB81736),),
                                        const SizedBox(width: 5),
                                        Text(
                                          newsList[index].newsAuthor.substring(0, 10),
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );}
                          catch(e){return Container(
                            height: 50,
                            width: screenWidth - 100,
                            child: Center(
                              child: Text('News not available',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.black
                                ),),
                            ),
                          );}
                        }),
                  )
                ],
              );
            }
            else{
              return Center(
                child: SpinKitCubeGrid(
                  color: Color(0xffB81736),
                  size: 80,
                ),
              );
            }
          },
        )
      );
  }
}
