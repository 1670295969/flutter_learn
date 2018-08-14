import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_zhihu_flutter/bean.dart';
import 'package:learn_zhihu_flutter/newsItem.dart';

class NewsListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsListStatus();
  }
}

//void main() {
//  http.get("https://news-at.zhihu.com/api/4/news/latest").then((resp) {
//    String respStr = resp.body;
//    print("haha->:" + respStr);
//    Map<String, dynamic> map = json.decode(respStr);
//
//    List barList = NewsItem.fromJsonWithBar(map["top_stories"]);
//    List contentList = NewsItem.fromJsonWithContent(map["stories"]);
//  });
//}

class NewsListStatus extends State<NewsListWidget> {
  ScrollController _scrollController;
  String _title = "newsList";
  List<NewsItem> barList;
  List<NewsItem> contentList;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMoreData);
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> _refreshData() {
    final Completer<Null> completer = new Completer<Null>();

    http.get("https://news-at.zhihu.com/api/4/news/latest").then((resp) {
      String respStr = resp.body;
      print(respStr);
      Map<String, dynamic> map = json.decode(respStr);

      barList = NewsItem.fromJsonWithBar(map["top_stories"]);
      contentList = NewsItem.fromJsonWithContent(map["stories"]);
      setState(() {});
    });

    completer.complete(null);

    return completer.future;
  }

  void _loadMoreData() {
    //TODO 加载更多数据
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("要加载更多数据了");
//      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: contentList == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: contentList == null ? 0 : contentList.length,
                itemBuilder: (context, index) {
                  return NewsItemWidget(contentList[index]);
                }),
      ),
    );
  }
}