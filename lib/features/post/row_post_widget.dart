import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';
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

  CategoryRepository _categoryRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _categoryRepository = Provider.of(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    return widget.data != null
        ? InkWell(
            onTap: () {
              widget.onchangePage(Tuple2('3',widget.data.docId));
            },
            child: Container(
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
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
                            widget?.data?.thumb ?? "",
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
                        child: FlatButton(
                          color: Colors.grey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          onPressed: () {
                            _showDelete();
                          },
                          child: Text(
                            'Xoá',
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),),
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

  Future<bool> _showDelete() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn có muốn xoá không ?'),
          actions: <Widget>[
            RaisedButton(
              onPressed: (){
                showDialogProgressLoading(context, _categoryRepository
                    .deletePost(widget.data.docId)).then((value){
                  if(value) {
                    widget.onLoad();
                    Navigator.of(context).pop();
                  }
                });
              },
              color: Colors.red,
              child: Text(
                  'Có'
              ),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              color: Colors.blue,
              child: Text(
                  'Không'
              ),
            )
          ],
        );
      },
    );
  }
}
