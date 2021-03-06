import 'package:flutter/material.dart';
import 'package:learn_zhihu_flutter/WebPage.dart';
import 'package:learn_zhihu_flutter/bean.dart';
import 'package:learn_zhihu_flutter/theme/theme.dart';

class NewsItemWidget extends StatefulWidget {
  final NewsItem item;

  NewsItemWidget(this.item);

  @override
  State<StatefulWidget> createState() {
    return NewsItemStatus(item);
  }
}

class NewsItemStatus extends State<NewsItemWidget> {
  final NewsItem item;

  NewsItemStatus(this.item);

  void _itemClick(BuildContext context) {
    WebPage.jump2Web(context, item.content, item.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _itemClick(context);
        },
        child: Card(
          child: Container(
              margin: EdgeInsets.fromLTRB(6.0, 4.0, 8.0, 4.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.content,
                            style: TextStyle(
                                color: ThemeColor.textColor(), fontSize: 14.0),
                          ),
                        ),
                      ),
                      Image.network(
                        item.url,
                        width: 80.0,
                        height: 80.0,
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
