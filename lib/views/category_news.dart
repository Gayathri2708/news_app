import 'package:flutter/material.dart';
import 'package:news_app/Helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Flutter",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "News",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.save)),
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 16),
                            child: ListView.builder(
                              itemCount: articles.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BlogTile(
                                  imageUrl: articles[index].urlToImage,
                                  title: articles[index].title,
                                  desc: articles[index].description,
                                  url: articles[index].url,
                                );
                              },
                            )),
                      ],
                    )),
              ));
  }
}
