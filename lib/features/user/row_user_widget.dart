import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/user.dart';
import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class RowUserWidget extends StatefulWidget {
  final User data;

  final int index;

  final VoidCallback onLoad;

  final ValueChanged<Tuple2<String,String>> onchangePage;

  RowUserWidget(this.data, this.index, this.onLoad, this.onchangePage);

  @override
  _RowUserWidgetState createState() => _RowUserWidgetState();
}

class _RowUserWidgetState extends State<RowUserWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
//        widget.onchangePage(Tuple2("2",widget.data.docId));
      },
      child: Container(
        color: widget.index % 2 == 0 ? Colors.grey[100] : Colors.lightBlueAccent[100],
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            _itemRow((widget.index + 1).toString()),
            _itemRow(widget.data.fullname),
            _itemRow(widget.data.username),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )
                ),
                child: Image.network(widget.data.avatar,height: 60,width: 60,),
              ),
            ),
            Expanded(child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  onPressed: (){
                    _showDelete().then((bool) {
                      setState(() {

                      });
                    });
                  },
                  child: Text(
                    'Xoá',
                    style: TextStyle(color: Colors.yellow),
                  ),
                )
            ),),
          ],
        ),
      ),
    );
  }

  Widget _itemRow(String title) {
    return Expanded(child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Text(title, textAlign: TextAlign.center,),
    ),);
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
                  debugPrint('user id : ${widget.data.docId}');
                showDialogProgressLoading(context, Provider.of<CategoryRepository>(context, listen: false)
                    .deleteUser(widget.data.docId)).then((value){
                  if(value) {
                    Navigator.of(context).pop();
                    widget.onLoad();
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