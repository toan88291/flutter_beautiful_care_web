import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:rich_code_editor/rich_code_editor.dart';
import 'package:tuple/tuple.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';

class DetailPostWidget extends StatefulWidget {
  final String id;

  ValueChanged<int> onLoad;

  DetailPostWidget(this.id,this.onLoad);

  @override
  _DetailPostWidgetState createState() => _DetailPostWidgetState();
}

class _DetailPostWidgetState extends State<DetailPostWidget> {

  List<SubCategory> dataSubCategory;

  Post datas;

  Uint8List bytesFromPicker;

  VoidCallback onLoad;

  CategoryRepository categoryRepository;

  GlobalKey<FormState> _formKey = GlobalKey();

  int content = 0;

  int image = 0;

  int video = 0;

  List<String> imageLink  = [];

  List<String> imageLinkDelete  = [];

  List<String> contentSaveFinal = [];

  String contentText = "";

  String contentSave;

  String title;

  Tuple2 _value;

  String thumb;

  String videoLink;

  List<String> contentData = [];
  
  List<Uint8List> imageFile = [];

  fb.UploadTask _uploadTask;

  fb.UploadTask _uploadTask2;

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
                              imageLinkDelete.add(element);
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

    if (imageFile.length != 0) {
      imageFile.forEach((element) {
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
                            child: Image.memory(
                              element,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  imageFile.remove(element);
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
    }

    item.add(Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: (){
          uploadMultipleImage();
        },
        color: Colors.blue,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    ));
    return item;
  }

  Future uploadImage() async {

    bytesFromPicker = await ImagePickerWeb.getImage(asUint8List: true);
    setState(() {

    });

  }

  Future uploadMultipleImage() async {
    Uint8List image = await ImagePickerWeb.getImage(asUint8List: true);
    setState(() {
      imageFile.add(image);
    });
  }

  Future<void> deleteImageStorage() async{
    if (bytesFromPicker != null && datas.thumb != null) {
      fb.storage().ref('make-up/tao-khoi').child(
          datas.thumb.replaceAll('https://firebasestorage.googleapis.com/v0/b/beautiful-care.appspot.com/o/make-up%2Ftao-khoi%2F', '').split('?')[0]
      ).delete();
    }
    if(imageLinkDelete.length > 0) {
      imageLinkDelete.forEach((element) {
        fb.storage().ref('make-up/tao-khoi').child(
            element.replaceAll('https://firebasestorage.googleapis.com/v0/b/beautiful-care.appspot.com/o/make-up%2Ftao-khoi%2F', '').split('?')[0]
        ).delete();
      });
    }
  }

  Future<void> uploadFile() async {
    int count = 0;
    await deleteImageStorage();
    Random random = new Random();
    int randomNumber = random.nextInt(100000000) +10 ;
    final filePath = randomNumber.toString()+'.png';
    if (imageLink.length > 0) {
      imageLink.forEach((element) {
        contentData.add('image:$element');
      });
    }
    if (bytesFromPicker != null && imageFile.length > 0) {
      debugPrint('1');
      _uploadTask = fb.storage().ref('make-up/tao-khoi').child(filePath).put(bytesFromPicker);
      _uploadTask.onStateChanged.listen((data) {
        data.task.snapshot.ref.getDownloadURL().then((value) {
          thumb = value.toString();
          debugPrint('2');
          for(int i=0; i< imageFile.length; i++) {
            debugPrint('3');
            _uploadTask2 = fb.storage().ref('make-up/tao-khoi').child(i.toString()+filePath).put(imageFile[i]);
            _uploadTask2.onStateChanged.listen((data2) {
              data2.task.snapshot.ref.getDownloadURL().then((value2) {
                contentData.add('image:$value2');
                debugPrint('4');
                setState(() {
                  count++;
                });
                if (count == imageFile.length) {
                  getContent();
                  categoryRepository.updatePost(widget.id, Post(
                      datas.category,
                      _value.item1,
                      datas.category_id,
                      thumb,
                      contentData,
                      datas.like,
                      datas.save,
                      _value.item2,
                      title,
                      datas.user_id
                  )).then((value2) {
                    if (value2) {
                      debugPrint('5');
                      widget.onLoad(0);
                    }
                  });
                }
              }).catchError((err){
                debugPrint('get link error : $err');
              }).catchError((error){
                debugPrint(' listen error: $error');
              });
            });
          }
        });
      });
    } else if (imageFile.length > 0){
      for(int i=0; i< imageFile.length; i++) {
        _uploadTask = fb.storage().ref('make-up/tao-khoi').child(i.toString()+filePath).put(imageFile[i]);
        _uploadTask.onStateChanged.listen((data2) {
          data2.task.snapshot.ref.getDownloadURL().then((value2) {
            contentData.add('image:$value2');
            setState(() {
              count++;
            });
            if (count == imageFile.length) {
              getContent();
              categoryRepository.updatePost(widget.id, Post(
                  datas.category,
                  _value.item1,
                  datas.category_id,
                  datas.thumb,
                  contentData,
                  datas.like,
                  datas.save,
                  _value.item2,
                  title,
                  datas.user_id
              )).then((value2) {
                if (value2) {
                  widget.onLoad(0);
                }
              });
            }
          });
        });
      }
    } else if (bytesFromPicker != null) {
      _uploadTask = fb.storage().ref('make-up/tao-khoi').child(filePath).put(bytesFromPicker);
      _uploadTask.onStateChanged.listen((data) {
        data.task.snapshot.ref.getDownloadURL().then((value) {
          thumb = value.toString();
          getContent();
          categoryRepository.updatePost(widget.id, Post(
              datas.category,
              _value.item1,
              datas.category_id,
              thumb,
              contentData,
              datas.like,
              datas.save,
              _value.item2,
              title,
              datas.user_id
          )).then((value2) {
            if (value2) {
              widget.onLoad(0);
            }
          });
        });
      });
    } else {
      getContent();
      categoryRepository.updatePost(widget.id, Post(
          datas.category,
          _value.item1,
          datas.category_id,
          datas.thumb,
          contentData,
          datas.like,
          datas.save,
          _value.item2,
          title,
          datas.user_id
      )).then((value2) {
        if (value2) {
          widget.onLoad(0);
        }
      });
    }
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
        _value = Tuple2(value.sub_category,value.sub_category_id);
        setState(() {
          datas = value;
          value.content.forEach((element) {
            if(element.contains('content:')) {
              content++;
              contentText = contentText +  element.substring(8,element.length);
            }else if(element.contains('image:')) {
              image++;
              imageLink.add(element.substring(6,element.length));
            } else {
              video++;
              videoLink = element.substring(6,element.length);
            }
          });
          categoryRepository
              .getListSubCategory(datas.category_id)
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

  void getContent() {
    debugPrint(
        contentSave
    );
    contentSaveFinal.clear();
    while(contentSave.contains('.\n')) {
      setState(() {
        contentSaveFinal.add('content:'+ contentSave.substring(0,contentSave.indexOf('.\n')+1));
        contentSave = contentSave.substring(contentSave.indexOf('.\n')+1, contentSave.length);
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
      contentSaveFinal.add('video:'+ videoLink);
      contentData = contentData + contentSaveFinal;
      debugPrint(
          'contentSaveFinal value: $contentData'
      );
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
                            initialValue: datas?.title,
                            decoration: InputDecoration(
                              hintText: datas?.title,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onSaved: (value) {
                              title = value;
                            },
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
                            hint: Text(datas?.sub_category ?? " ",style: TextStyle(
                              color: Colors.black,
                            ),),
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
                                datas?.thumb != null ? datas.thumb : " ",
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
                              contentPadding: EdgeInsets.only(left: 12),
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
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text('Video :'),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: 'Nội Dung',
                            contentPadding: EdgeInsets.only(left: 12),
                          ),
                          initialValue: videoLink,
                          onSaved: (value) {
                            videoLink = value;
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
                child: Container(
                  child: FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        uploadFile();
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
      visible: datas != null ? true : false,
    );
  }
}
