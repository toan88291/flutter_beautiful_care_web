import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:rich_code_editor/rich_code_editor.dart';
import 'package:tuple/tuple.dart';

class DetailPostWidget extends StatefulWidget {
  final String id;

  DetailPostWidget(this.id);

  @override
  _DetailPostWidgetState createState() => _DetailPostWidgetState();
}

class _DetailPostWidgetState extends State<DetailPostWidget> {

  List<SubCategory> dataSubCategory;

  Post data;

  Uint8List bytesFromPicker;

  VoidCallback onLoad;

  CategoryRepository categoryRepository;

  GlobalKey<FormState> _formKey = GlobalKey();

  Tuple2 _value;

  int content = 0;

  int image = 0;

  int video = 0;

  List<String> imageLink  = [];

  List<String> contentSaveFinal = [];

  String contentText = "";

  String contentSave;

  List<DropdownMenuItem<Tuple2>> getCateGory() {
    List<DropdownMenuItem<Tuple2>> item = [];
    try {
      dataSubCategory?.forEach((element) {
        item.add(DropdownMenuItem(
          value: Tuple2(element.name, element.docId),
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

  List<Widget> getImage() {
    List<Widget> item = [];
    imageLink.forEach((element) {
      item.add(
        Stack(
          children: <Widget>[
            Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.network(
                          element,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              imageLink.remove(element);
                              debugPrint('data: $imageLink');
                            });
                          },
                          icon: Icon(Icons.cancel,color: Colors.red,),
                        ),
                      )
                    ],
                  ),
                )
            ),
          ],
        )
      );
    });
    item.add(Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: (){},
        color: Colors.blue,
        child: Icon(Icons.add),
      ),
    ));
    return item;
  }

  Future uploadImage() async {

    bytesFromPicker = await ImagePickerWeb.getImage(asUint8List: true);
    setState(() {

    });

  }

  @override
  void initState() {
    super.initState();
    categoryRepository = Provider.of(context, listen: false);
    onLoad = () {
      categoryRepository.getPostId(widget.id).then((value) {
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getPostId(widget.id).then((value) {
      if(value != null) {
        setState(() {
          data = value;
          value.content.forEach((element) {
            if(element.contains('content:')) {
              content++;
              contentText = contentText + '\n' +  element.substring(8,element.length) ;
            }else if(element.contains('image:')) {
              image++;
              imageLink.add(element.substring(6,element.length));
            } else {
              video++;
            }
          });
          categoryRepository
              .getListSubCategory(data.category_id)
              .then((data) {
            if (data.isNotEmpty) {
              setState(() {

                dataSubCategory = data;
              });
            }
          });
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Form (
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(28),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                    child: Text(
                      'Thông tin bài viết',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Theme.of(context).primaryColor),
                    )),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text('Tiêu Đề Bài Viết :'),
                    ),
                    Expanded(
                        child: Container(
                          height: 52,
                          padding: EdgeInsets.only(left: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextFormField(
                            initialValue: data?.title,
                            decoration: InputDecoration(
                              hintText: data?.title,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 12,),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text('Danh Mục Bài Viết :'),
                    ),
                    Expanded(
                        child: Container(
                          height: 52,
                          padding: EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: DropdownButton<Tuple2>(
                            hint: Text(data?.sub_category ?? " "),
                            underline: Container(
                              color: Colors.white,
                            ),
                            items: getCateGory(),
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            },
                            value: _value,
                            isExpanded: true,
                          ),
                        ))
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 12,),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text('Ảnh bìa :'),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image:  DecorationImage(
                              image: bytesFromPicker == null ? NetworkImage(
                                data?.thumb != null ? data.thumb : " ",
                              ) : MemoryImage(bytesFromPicker),
                              fit: BoxFit.fill
                          )
                      ),
                      child: FlatButton(
                        onPressed: (){
                          uploadImage();
                        },
                        color: Colors.white.withOpacity(0.7),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Thay Ảnh',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 12,),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text('Nội Dung :'),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextFormField(
                          maxLines: 10,
                          textInputAction: TextInputAction.newline,
                          initialValue: contentText ?? "",
                          decoration: InputDecoration(
                              hintText: 'Nội Dung',
                          ),
                          onSaved: (value) {
                            contentSave = value;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 12,),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text('Ảnh :'),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: getImage(),
                        )
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 12,),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        contentSaveFinal.clear();
                        while(contentSave.contains('.\n')) {
                          setState(() {
                            contentSaveFinal.add('content:'+ contentSave.substring(0,contentSave.indexOf('.\n')+1));
                            contentSave = contentSave.substring(contentSave.indexOf('.\n')+1, contentSave.length);
                            debugPrint(
                                'contentSaveFinal value: $contentSaveFinal'
                            );
                            debugPrint(
                                'contentSave value: $contentSave'
                            );
                          });
//                          if(contentSave.contains('.\n')) {
//                            setState(() {
//                              contentSaveFinal.add(contentSave.substring(0,contentSave.indexOf('.\n')+1));
//                              contentSave = contentSave.substring(contentSave.indexOf('.\n')+1, contentSave.length);
//                              debugPrint(
//                                  'contentSaveFinal value: $contentSaveFinal'
//                              );
//                              debugPrint(
//                                  'contentSave value: $contentSave'
//                              );
//                            });
//                          } else {
//                            setState(() {
//                              contentSaveFinal.add(contentSave);
//                              debugPrint(
//                                  'contentSaveFinal value: $contentSaveFinal'
//                              );
//                            });
//                          }
                        }
                        setState(() {
                          contentSaveFinal.add('content:'+ contentSave);
                          debugPrint(
                              'contentSaveFinal value: $contentSaveFinal'
                          );
                        });
                      }
                    },
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                )
              ))
            ],
          ),
        ),
      ),
      visible: data != null ? true : false,
    );
  }
}
