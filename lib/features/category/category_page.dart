import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'header_category_widget.dart';
import 'row_category_widget.dart';

class CategoryPage extends StatefulWidget {

  final ValueChanged<Tuple2<String,String>> onchangePage;

  CategoryPage(this.onchangePage);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Category> data;

  VoidCallback onLoad;

  CategoryRepository categoryRepository;

  @override
  void initState() {
    super.initState();
    categoryRepository = Provider.of(context,listen: false);
    onLoad = (){
      data = null;
      categoryRepository.getListCategory().then((value){
        setState(() {
          data = value;
        });
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getListCategory().then((value){
      setState(() {
        data = value;
      });
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
                  itemBuilder: (context, index) => RowCategoryWidget(data[index], index, onLoad, widget.onchangePage),
                  itemCount: data?.length ?? 0,
                  separatorBuilder: (context, index) => Container( color: Colors.transparent, child: const Divider( ), ),

                )
            )
          ],
        ),
      ],
    ) : Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}