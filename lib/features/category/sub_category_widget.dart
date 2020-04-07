import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:provider/provider.dart';

import 'header_category_widget.dart';
import 'input_sub_category_widget.dart';
import 'row_sub_category_widget.dart';

class SubCategoryWidget extends StatefulWidget {
  final String id;

  SubCategoryWidget(this.id);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {

  List<SubCategory> data;

  VoidCallback onLoad;

  CategoryRepository categoryRepository;

  @override
  void initState() {
    super.initState();
    categoryRepository = Provider.of(context,listen: false);
    onLoad = (){
      data = null;
      categoryRepository.getListSubCategory(widget.id).then((value){
        if(value != null) {
          setState(() {
            data = value;
          });
        }
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getListSubCategory(widget.id).then((value){
      if(value != null) {
        setState(() {
          data = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return data != null ? Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Column(
          children: <Widget>[
            HeaderCategoryWidget(),
            Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => RowSubCategoryWidget(data[index], widget.id, index, onLoad),
                  itemCount: data?.length ?? 0,
                  separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),
                )
            )
          ],
        ),
        Positioned(
          bottom: 0,
          right: -12,
          child: FloatingActionButton(
            onPressed: () {
                _showInput().then((value) => {});
            },
            child: Icon(Icons.add, color: Colors.white,),
          ),
        )
      ],
    ) : Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Future<void> _showInput() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: InputSubCategoryWidget(widget.id,onLoad)
        );
      },
    );
  }

}