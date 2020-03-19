import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:tuple/tuple.dart';

class RowPostWidget extends StatefulWidget {
  final Post data;

  final int index;

  final VoidCallback onLoad;

  final ValueChanged<Tuple2<String,String>> onchangePage;

  RowPostWidget(this.data, this.index, this.onLoad, this.onchangePage);

  @override
  _RowPostWidgetState createState() => _RowPostWidgetState();
}

class _RowPostWidgetState extends State<RowPostWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.data != null
        ? InkWell(
            onTap: () {
              widget.onchangePage(Tuple2('3',widget.data.docId));
            },
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    child: _itemRow((widget.index + 1).toString()),
                  ),
                  Expanded(
                    child: _itemRow(widget.data.title),
                  ),
                  Expanded(
                    child: _itemRow(widget.data.sub_category),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.data.image,
                          )
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: _itemRow(widget.data.like.length.toString()),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              onPressed: () {
//                                _showUpdate().then((bool) {});
                              },
                              child: Text(
                                'Xoá',
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            FlatButton(
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              onPressed: () {
//                    _showUpdate().then((bool) {});
                              },
                              child: Text(
                                'Sửa',
                                style: TextStyle(color: Colors.yellow),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _itemRow(String title) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
