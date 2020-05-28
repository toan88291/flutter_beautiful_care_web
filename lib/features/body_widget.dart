import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'post/input_post_widget.dart';
import 'post/row_post_widget.dart';
import 'dart:developer' as developer;

import 'post/header_post_widget.dart';

class BodyWidget extends StatefulWidget {
  final ValueChanged<Tuple2<String,String>> onchangePage;

  BodyWidget(this.onchangePage);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  static const TAG = 'BodyWidget';

  List<Category> dataCategory;

  List<Post> dataPost;

  List<SubCategory> dataSubCategory;

  VoidCallback onLoad;

  VoidCallback onLoadPost;

  CategoryRepository categoryRepository;

  String _value;

  bool showCategory = false;

  bool showPost = false;

  bool loadDing = false;

  int index;

  List<DropdownMenuItem<String>> getCateGory() {
    List<DropdownMenuItem<String>> item = [];
    try {
      dataCategory.forEach((element) {
        item.add(DropdownMenuItem(
          value: element.docId,
          child: Text(
            element.name,
          ),
        ));
      });
    } catch (err) {
      debugPrint('error $err');
    }
    return item;
  }

  @override
  void initState() {
    super.initState();
    categoryRepository =
        Provider.of<CategoryRepository>(context, listen: false);
    onLoad = () {
      categoryRepository.getListCategory().then((value) {
        setState(() {
          dataCategory = value;
        });
      });
    };

    onLoadPost = (){
      categoryRepository
          .getPost(dataSubCategory[index].docId)
          .then((value) {
        if (value.isNotEmpty) {
          setState(() {
            dataPost = value;
          });
        } else {
          setState(() {
            dataPost = [];
          });
        }
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getListCategory().then((value) {
      setState(() {
        dataCategory = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return dataCategory != null
        ? Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Chọn Danh Mục',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      Container(
                        height: 48,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 200,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: DropdownButton<String>(
                                hint: Text("Danh Mục"),
                                items: getCateGory(),
                                underline: Container(
                                  color: Colors.white,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                                value: _value,
                                isExpanded: true,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 48,
                              constraints: BoxConstraints(
                                minHeight: 38
                              ),
                              child: RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  if(_value != null) {
                                    setState(() {
                                      loadDing = true;
                                    });
                                    categoryRepository
                                        .getListSubCategory(_value)
                                        .then((data) {
                                      if (data.isNotEmpty) {
                                        setState(() {
                                          showCategory = true;
                                          loadDing = false;
                                          dataSubCategory = data;
                                        });
                                      }
                                    });
                                  }
                                },
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: loadDing
                                    ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2,
                                )
                                    : Text(
                                  'Xem',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Visibility(
                        visible: showCategory,
                        child: Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: ListView.builder(
                              itemCount: dataSubCategory?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      showCategory = false;
                                      this.index = index;
                                      categoryRepository
                                          .getPost(dataSubCategory[index].docId)
                                          .then((value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            dataPost = value;
                                          });
                                        } else {
                                          setState(() {
                                            dataPost = [];
                                          });
                                        }
                                      });
                                    });
                                  },
                                  leading: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                            image: NetworkImage(
                                              dataSubCategory[index]?.image,
                                            ))),
                                  ),
                                  title: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      dataSubCategory[index].name,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            HeaderPostWidget(),
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => RowPostWidget(
                                    dataPost[index],
                                    index,
                                    onLoadPost,
                                    widget.onchangePage
                                ),
                                itemCount: dataPost?.length ?? 0,
                                separatorBuilder: (context, index) => Container(
                                  color: Colors.transparent,
                                  child: const Divider(),
                                ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -12,
                child: FloatingActionButton(
                  onPressed: () {
                    _showInput().then((value) => {});
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  Future<void> _showInput() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: InputPostWidget(onLoadPost),
        );
      },
    );
  }
}
