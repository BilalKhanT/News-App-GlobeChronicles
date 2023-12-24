import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/home.dart';
import 'package:provider/provider.dart';

import '../database/db_service.dart';
import '../model/news_model.dart';
import '../provider/saved_provider.dart';

class NewsScreen extends StatefulWidget {

  String name;
  NewsModel instance;

  NewsScreen(
      {
        required this.name,
      required this.instance});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  var DatabaseHelper;

  @override
  void initState() {
    DatabaseHelper = DataBaseService();
    super.initState();
  }

  insertSavedNews() async{
    int id = await DataBaseService.insertNewsForUser(widget.instance, widget.name);
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            height: screenHeight * 0.4,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Hero(
                tag: widget.instance,
                child: Image.network(
                  widget.instance.newsImg,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 40,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.withAlpha(150)),
                          child:  Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 3),
                                child: Icon(Icons.person_outline_outlined, color: Color(0xffB81736),),
                              ),
                              Expanded(
                                child:
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(widget.instance.newsAuthor,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 12
                                    ),
                                    maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: Color(0xffB81736),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 10),
                              child: Text(
                                widget.instance.newsDate.substring(0, 10),
                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<SavedProvider>(
                        builder: (context, savedNewsProvider, child) => IconButton(
                          iconSize: 30,
                            onPressed: () async {
                              await insertSavedNews();
                            },
                            icon: Icon(Icons.bookmark_border_outlined,
                            color: Color(0xffB81736),)),
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      widget.instance.newsTitle,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 30, right: 10),
                      child: Text(widget.instance.newsContent,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
