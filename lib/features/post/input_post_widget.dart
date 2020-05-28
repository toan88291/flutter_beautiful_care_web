import 'dart:math';
import 'dart:typed_data';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class InputPostWidget extends StatefulWidget {
  final VoidCallback onLoad;

  InputPostWidget(this.onLoad);

  @override
  _InputPostWidgetState createState() => _InputPostWidgetState();
}

class _InputPostWidgetState extends State<InputPostWidget> {
  GlobalKey<FormState> _formKey = GlobalKey();

  CategoryRepository categoryRepository;

  List<Category> dataCategory;

  List<SubCategory> dataSubCategory;

  String title;

  String thumb;

  String videoLink;

  Tuple2 valueCategory;

  Tuple2 valueSubCategory;

  Uint8List bytesFromPicker;

  List<Uint8List> imageFile = [];

  String contentSave;

  bool loadding = false;

  bool titleError = false;

  bool contentError = false;

  bool check = false;

  fb.UploadTask _uploadTask;

  fb.UploadTask _uploadTask2;

  List<String> contentData = [];

  List<String> contentSaveFinal = [];

  List<Widget> getImage() {
    List<Widget> item = [];

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
      margin: EdgeInsets.only(left: 12),
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

  List<DropdownMenuItem<Tuple2>> getCateGory() {
    List<DropdownMenuItem<Tuple2>> item = [];
    try {
      dataCategory?.forEach((element) {
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

  List<DropdownMenuItem<Tuple2>> getSubCateGory() {
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

  Future uploadMultipleImage() async {
    Uint8List image = await ImagePickerWeb.getImage(asUint8List: true);
    setState(() {
      imageFile.add(image);
    });
  }

  Future uploadImage() async {

    bytesFromPicker = await ImagePickerWeb.getImage(asUint8List: true);
    setState(() {

    });

  }

  Future<void> putData() async {
    int count = 0;
    int i=0;
    Random random = new Random();
    int randomNumber = random.nextInt(100000000) +10 ;
    String path;
    debugPrint('1');
    final filePath = randomNumber.toString()+'.png';
    switch (valueCategory.item2) {
      case '47RauuVFfeAnxwf8ZPA5' :
        path = 'make-up';
        break;
      case 'WtYq7Bl2EhR0tclLO586' :
        path = 'mac-dep';
        break;
      case 'hnRHpT10rFIea2QQTnqc' :
        path = 'dang-dep';
        break;
      case 'luOl5F551s0lg9x4qYwz' :
        path = 'toc-dep';
        break;
      case 'ngk0fShOLMKyxOIBieEs' :
        path = 'the-thao';
        break;
      default:
        path = 'da-dep';
        break;
    }
    debugPrint('2');
    _uploadTask = fb.storage().ref(path).child(filePath).put(bytesFromPicker);

    _uploadTask.onStateChanged.listen((data) {
//      debugPrint('onStateChanged ${data.state}');
//
//      int value1 = _uploadTask.snapshot.totalBytes;
//      int value2 = _uploadTask.snapshot.bytesTransferred;
//      debugPrint('onStateChanged ${value1}');
//      debugPrint('onStateChanged ${value2}');
    }, onDone: () {
      debugPrint('Upload done}');
      _uploadTask.snapshot.ref.getDownloadURL().then((value) {
        thumb = value.toString();
        debugPrint('getDownloadURL ${thumb}');
          for(int i=0; i < imageFile.length; i++) {
            debugPrint('number $i');
            _uploadTask = fb.storage().ref(path).child(i.toString()+filePath).put(imageFile[i]);
            _uploadTask.onStateChanged.listen((data2) {
            },onDone: (){
              _uploadTask.snapshot.ref.getDownloadURL().then((value2) {
                debugPrint('4 : $value2');
                contentData.add('image:$value2');
                debugPrint('5');
                setState(() {
                  count++;
                });
                debugPrint('6');
                if (count == imageFile.length) {
                  getContent();
                  categoryRepository.insertPost(
                      Post(
                          valueCategory.item1,
                          valueSubCategory.item1,
                          valueCategory.item2,
                          thumb,
                          contentData,
                          [],
                          valueSubCategory.item2,
                          title,
                          '',
                          DateTime.now()
                      )
                  ).then((value3) {
                    if (value3) {
                      debugPrint('9');
                      Navigator.of(context).pop();
                      widget.onLoad();
                      debugPrint('10');
                    }
                  });
                }
              }).catchError((error) {
                debugPrint('error: ${error}');
              });
            });
          }
      }).catchError((err) {
        debugPrint('InputPostWidget error 2: ${err}');
      });

    }, onError: (error) {
      debugPrint('Upload errror}');
    });
  }

  void getContent() {
    debugPrint(
        contentSave
    );
    contentSaveFinal.clear();
    while(contentSave.contains('.\n')) {
      setState(() {
        contentSaveFinal.add('content:'+ contentSave.substring(0,contentSave.indexOf('.\n')+1).trim());
        contentSave = contentSave.substring(contentSave.indexOf('.\n')+1, contentSave.length);
      });
    }
    setState(() {
      contentSaveFinal.add('content:'+ contentSave.trim());
      contentSaveFinal.add('video:'+ videoLink);
      contentData = contentData + contentSaveFinal;
      debugPrint(
          'contentSaveFinal value: $contentData'
      );
    });
    debugPrint('7');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository = Provider.of(context, listen: false);

    categoryRepository
        .getListCategory()
        .then((data) {
      if (data.isNotEmpty) {
        setState(() {
          dataCategory = data;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Form (
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
                          decoration: InputDecoration(
                            hintText: 'Tiêu đề',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onSaved: (value) {
                            title = value;
                          },
                          validator: (value){
                            if(value.isEmpty) {
                              titleError = true;
                              return null;
                            }else {
                              return null;
                            }
                          },
                        ),
                      ))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24,child: Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Visibility(
                  child: Text('Chưa nhập tiêu đề',style: TextStyle(color: Colors.red)),
                  visible: titleError,
                ),
              )),
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
                          hint: Text(" ",style: TextStyle(
                            color: Colors.black,
                          ),),
                          underline: Container(
                            color: Colors.white,
                          ),
                          items: getCateGory(),
                          onChanged: (value) {
                            setState(() {
                              setState(() {
                                valueCategory = value;
                              });
                            });
                            categoryRepository
                                .getListSubCategory(valueCategory.item2)
                                .then((data) {
                              if (data.isNotEmpty) {
                               setState(() {
                                 dataSubCategory = data;
                               });
                              }
                            });
                          },
                          value: valueCategory,
                          isExpanded: true,
                        ),
                      ))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24,child: Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Visibility(
                  child: Text('Chưa chọn danh mục',style: TextStyle(color: Colors.red)),
                  visible: valueCategory == null && check,
                ),
              ),),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Text('Danh Mục Con :'),
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
                          hint: Text(" ",style: TextStyle(
                            color: Colors.black,
                          ),),
                          underline: Container(
                            color: Colors.white,
                          ),
                          items: getSubCateGory(),
                          onChanged: (value) {
                            setState(() {
                              valueSubCategory = value;
                            });
                          },
                          value: valueSubCategory,
                          isExpanded: true,
                        ),
                      ))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24,child: Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Visibility(
                  child: Text('Chưa chọn danh mục con',style: TextStyle(color: Colors.red)),
                  visible: valueSubCategory == null && check,
                ),
              )),
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
                            image: bytesFromPicker == null ? AssetImage(
                              'assets/image_empty.png'
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
              child: SizedBox(height: 24,child: Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Visibility(
                  child: Text('Chưa chọn ảnh',style: TextStyle(color: Colors.red)),
                  visible: bytesFromPicker == null && check,
                ),
              )),
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
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Nội Dung',
                        ),
                        onSaved: (value) {
                          contentSave = value;
                        },
                        validator: (value){
                          if(value.isEmpty) {
                            contentError = true;
                            return null;
                          }else {
                            return null;
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24,child: Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Visibility(
                  child: Text('Chưa nhập nội dung',style: TextStyle(color: Colors.red)),
                  visible: contentError ,
                ),
              )),
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
                        child: Wrap(
                          children: getImage(),
                        )
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24,child: Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Visibility(
                  child: Text('Chưa chọn ảnh mô tả ',style: TextStyle(color: Colors.red)),
                  visible: imageFile.length == 0 && check,
                ),
              )),
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
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          setState(() {
                            loadding = true;
                            check  = true;
                          });
                          putData();
                        }
                      },
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: loadding == false ? Text(
                        'Đăng Bài',
                        style: TextStyle(color: Colors.white),
                      ) : Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.white,)
                      ),
                    )
                ))
          ],
        ),
      ),
    );
  }

}