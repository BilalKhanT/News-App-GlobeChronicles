import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/profile.dart';
import 'package:news_app/screens/search.dart';
import '../database/db_service.dart';
import '../model/news_model.dart';
import 'home.dart';

class BookMarkScreen extends StatefulWidget {
  String username;
  BookMarkScreen({required this.username});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  late Future<List<NewsModel>> userSavedNews;

  @override
  void initState() {
    super.initState();
    userSavedNews = getNews();
  }

  Future<List<NewsModel>> getNews() async {
    return await DataBaseService.retrieveNewsForUser(widget.username);
  }

  deleteNews(String title) async{
    await DataBaseService.deleteSavedNews(widget.username, title);
      Navigator.push(context, MaterialPageRoute(builder: (context) => BookMarkScreen(username: widget.username)));
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Saved News",
                  style: GoogleFonts.poppins(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.lock,
                  color: Color(0xffB81736),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder<List<NewsModel>>(
              future: userSavedNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: SpinKitCubeGrid(
                    color: Color(0xffB81736),
                    size: 80,
                  ),);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<NewsModel> newsList = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 2,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
                          ),
                          Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) => deleteNews(newsList[index].newsTitle),
                                  icon: Icons.delete,
                                  backgroundColor: Color(0xffB81736),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(newsList[index].newsImg),
                                      fit: BoxFit.fitHeight,
                                    ),
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.access_time, color: Color(0xffB81736),),
                                              const SizedBox(width: 5),
                                              Text(newsList[index].newsDate.substring(0, 10), style: GoogleFonts.poppins(
                                                color: Colors.black54,
                                              ),),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.person_outline_outlined, color: Color(0xffB81736),),
                                              const SizedBox(width: 5),
                                              Text(
                                                newsList[index].newsAuthor,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}