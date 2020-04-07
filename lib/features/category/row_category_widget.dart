import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:tuple/tuple.dart';

import 'update_category_widget.dart';

class RowCategoryWidget extends StatefulWidget {

  final Category data;

  final int index;

  final VoidCallback onLoad;

  final ValueChanged<Tuple2<String,String>> onchangePage;

  RowCategoryWidget(this.data, this.index, this.onLoad, this.onchangePage);

  @override
  _RowCategoryWidgetState createState() => _RowCategoryWidgetState();
}

class _RowCategoryWidgetState extends State<RowCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onchangePage(Tuple2("2",widget.data.docId));
      },
      child: Container(
        color: widget.index % 2 == 0 ? Colors.grey[100] : Colors.blue[100],
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            _itemRow((widget.index + 1).toString()),
            _itemRow(widget.data.name),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )
                ),
                child: Image.network(widget.data.icon,height: 60,width: 60,),
              ),
            ),
            Expanded(child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  onPressed: (){
                    _showUpdate().then((bool) {
                      setState(() {

                      });
                    });
                  },
                  child: Text(
                    'Sửa',
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

  Future<bool> _showUpdate() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: UpdateCategoryWidget(widget.data,widget.onLoad),
        );
      },
    );
  }

}