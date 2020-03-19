import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';

import 'update_sub_category_widget.dart';

class RowSubCategoryWidget extends StatefulWidget {

  final SubCategory data;

  final String id;

  final int index;

  final VoidCallback onLoad;
  
  RowSubCategoryWidget(this.data, this.id, this.index, this.onLoad);

  @override
  _RowSubCategoryWidgetState createState() => _RowSubCategoryWidgetState();
}

class _RowSubCategoryWidgetState extends State<RowSubCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          _itemRow((widget.index + 1).toString()),
          _itemRow(widget.data.name),
          Expanded(
            child: Image.network(widget.data.image, width: 52, height: 52,),
          ),
          Expanded(child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              child: FlatButton(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                onPressed: (){
                  _showUpdate().then((bool) {});
                },
                child: Text(
                  'Sửa',
                  style: TextStyle(color: Colors.yellow),
                ),
              )
          ),),
        ],
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
          child: UpdateSubCategoryWidget(widget.id,widget.data,widget.onLoad),
        );
      },
    );
  }

}