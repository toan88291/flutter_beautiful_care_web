import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';

import 'update_category_widget.dart';

class RowCategoryWidget extends StatefulWidget {

  final Category data;

  final int index;

  final VoidCallback onLoad;

  RowCategoryWidget(this.data, this.index, this.onLoad);

  @override
  _RowCategoryWidgetState createState() => _RowCategoryWidgetState();
}

class _RowCategoryWidgetState extends State<RowCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          _itemRow((widget.index + 1).toString()),
          _itemRow(widget.data.name),
          Expanded(
            child: Image.network(widget.data.icon, width: 52, height: 52,),
          ),
          Expanded(child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                _showUpdate();
              },
              child: Text(
                'Sửa',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
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

  Future<void> _showUpdate() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: UpdateCategoryWidget(widget.data),
        );
      },
    );
  }

}