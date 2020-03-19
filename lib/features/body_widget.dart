import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
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

  CategoryRepository categoryRepository;

  String _value;

  bool showCategory = false;

  bool showPost = false;

  bool loadDing = false;

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
      categoryRepository.getList().then((value) {
        setState(() {
          dataCategory = value;
        });
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getList().then((value) {
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
                              width: 160,
                              child: DropdownButton<String>(
                                hint: Text("Danh Mục"),
                                items: getCateGory(),
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
                            FlatButton(
                              color: Colors.blue,
                              onPressed: () {
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
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: loadDing
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 4,
                                    )
                                  : Text(
                                      'Xem',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Visibility(
                        visible: showCategory,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: dataSubCategory?.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    showCategory = false;
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
                                    onLoad,
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
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(),
        );
      },
    );
  }
}
