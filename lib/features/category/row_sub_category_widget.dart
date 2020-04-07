import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';

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

  CategoryRepository _categoryRepository;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _categoryRepository = Provider.of(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index % 2 == 0 ? Colors.grey[100] : Colors.blue[100],
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          _itemRow((widget.index + 1).toString()),
          _itemRow(widget.data.name),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
                image: DecorationImage(
                  image: NetworkImage(widget.data.image)
                )
              ),
            ),
          ),
          Expanded(child: Row(
            children: <Widget>[
              Container(
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
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  child: FlatButton(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    onPressed: (){
                      _showDelete().then((value){
                        setState(() {

                        });
                      });
                    },
                    child: Text(
                      'Xoá',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              )
            ],
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
                    .deleteSubCategory(widget.id, widget.data.docId)).then((value){
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