import 'dart:html' as html;
import 'dart:typed_data';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/sub_category.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';

class InputSubCategoryWidget extends StatefulWidget {

  final String id;

  final VoidCallback onLoad;

  InputSubCategoryWidget(this.id, this.onLoad);

  @override
  _InputSubCategoryWidgetState createState() => _InputSubCategoryWidgetState();
}

class _InputSubCategoryWidgetState extends State<InputSubCategoryWidget> {

  GlobalKey<FormState> globalKey = GlobalKey();

  Uint8List bytesFromPicker;

  String nameCateGory;

  bool loadDing = false;

  bool checkError = false;

  StorageReference storageReference;

  CategoryRepository categoryRepository;

  final fs.Firestore firestore = fb.firestore();

  html.File uploadedImage;

  StorageUploadTask uploadTask;

  FirebaseStorage storage;

  fb.StorageReference ref;

  Image pickedImage;

  fb.UploadTask _uploadTask;

  uploadToFireBase(Uint8List imageFile) async {
    final filePath = '${DateTime.now()}.png';
    _uploadTask = fb.storage().ref('icon').child(filePath).put(imageFile);
    _uploadTask.onStateChanged.listen((data) {
      data.ref.getDownloadURL().then((value) {
        debugPrint('link image: ${value.toString()}');
        Map<String,dynamic> map;
        map = {
          'image' : value.toString(),
          'name' : nameCateGory,
        };
        SubCategory subCategory = SubCategory(
          value.toString(),
          nameCateGory
        );
        try {
          categoryRepository
              .insertSubCateGory(widget.id, map)
              .then((value) {
            if (value) {
              setState(() {
                loadDing = false;
                widget.onLoad();
                Navigator.of(context).pop(true);
              });
            }
          });
        } catch (err) {
          debugPrint('error: $err');
        }
      });
    });
  }

  Future uploadImage() async {
    bytesFromPicker = await ImagePickerWeb.getImage(asUint8List: true);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    categoryRepository = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            width: 500,
            height: 500,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "THÊM DANH MỤC CON",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Tên danh mục',
                                labelText: 'Tên danh mục',
                                filled: true),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Không được để trống !';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              nameCateGory = value;
                            },
                          ),
                          Divider(
                            height: 32,
                            color: Colors.transparent,
                          ),
                          Container(
                            child: bytesFromPicker == null
                                ? Icon(Icons.image, size:  40,) : Image.memory(bytesFromPicker,
                                height: 120, width: 120, fit: BoxFit.fill),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Visibility(
                            child: Text(
                              'Bạn chưa chọn ảnh !',
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Colors.red,
                              ),
                            ),
                            visible: checkError,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () {
                              uploadImage();
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                'Chọn Ảnh',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          if (globalKey.currentState.validate() && bytesFromPicker != null) {
                            globalKey.currentState.save();
                            setState(() {
                              checkError = true;
                              loadDing = true;
                            });
                            uploadToFireBase(bytesFromPicker);
                          } else {
                            setState(() {
                              checkError = true;
                            });
                          }
                        },
                        child: loadDing
                            ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                            : Text(
                          'LƯU',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'HUỶ',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}