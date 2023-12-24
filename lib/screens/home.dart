import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/screens/news.dart';
import 'package:news_app/screens/profile.dart';
import 'package:news_app/screens/search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/screens/sidemenu.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/news_model.dart';
import '../provider/saved_provider.dart';
import '../utils/images.dart';
import 'bookmark.dart';

class HomeScreen extends StatefulWidget {
  String username;
  HomeScreen({required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future news = getNews(0, '');
  List<NewsModel> newsList = <NewsModel>[];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Consumer<SavedProvider>(
      builder: (context, newsProvider, child) => Scaffold(
        drawer: SideMenu(),
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
                          onPressed: () {},
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(username: widget.username, flag: 0, query: '')));
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
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: news,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {
              List<NewsModel> newsList = snapshot.data;
              NewsModel newsModel = newsList[4];

                       return Column(
                children: [
                  Container(
                      height: screenHeight * 0.4,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            newsModel.newsImg,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                      ),
                      child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                              child: InkWell(
                                onTap: (){
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffB81736),
                                  ),
                                  child: Icon(Icons.line_weight_outlined, color: Colors.white,),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      height: 30,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.withAlpha(150)),
                                      child: Center(
                                        child: Text(
                                          "News of the day",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          newsModel.newsDes,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Learn more",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,),
                                          ),
                                          IconButton(
                                            iconSize: 20,
                                            onPressed: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsScreen(name: widget.username, instance: newsModel,)));
                                            },
                                            icon: Icon(Icons.arrow_forward),
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Breaking News",
                                style: GoogleFonts.poppins(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                Icons.account_balance,
                                size: 30,
                                color: Color(0xffB81736),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                          child: Container(
                            height: 2,
                            color: Color(0xffB81736),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          child: CarouselSlider(
                            options: CarouselOptions(
                                height: 200,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlayAnimationDuration: Duration(seconds: 5),
                                autoPlay: true,
                                enlargeCenterPage: true,
                                initialPage: 2,
                                scrollDirection: Axis.horizontal),
                            items: newsList.map((instance) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => NewsScreen(
                                                     instance: instance, name: widget.username,
                                                  )));
                                    },
                                    child: Container(
                                        child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Hero(
                                                tag: instance,
                                                child: CachedNetworkImage(
                                                  imageUrl: instance.newsImg,
                                                  errorWidget: (context, url, error) => Image.asset(AssetImages.appLogo) ,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xffB81736),
                                                          Color(0xff281537),
                                                        ],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      )),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 5, vertical: 5),
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        instance.newsTitle,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                    )),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                  child: SpinKitCubeGrid(
                    color: Color(0xffB81736),
                    size: 80,
                  ),
              );
            }
          },
        ),
      ),
    );
  }
}
