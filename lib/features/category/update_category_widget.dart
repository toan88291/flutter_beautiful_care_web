import 'dart:async';
import 'dart:html' as html;
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';



class UpdateCategoryWidget extends StatefulWidget {

  final Category data;

  final VoidCallback onLoad;

  UpdateCategoryWidget(this.data, this.onLoad);

  @override
  _UpdateCategoryWidgetState createState() => _UpdateCategoryWidgetState();
}

class _UpdateCategoryWidgetState extends State<UpdateCategoryWidget> {
  static const TAG = 'UpdateCategoryWidget';

  GlobalKey<FormState> globalKey = GlobalKey();

  String nameCateGory;

  String icon;

  String name ;

  String error;

  String imageLink;

  CategoryRepository categoryRepository;

  final fs.Firestore firestore = fb.firestore();

  Uint8List bytesFromPicker;

  html.File uploadedImage;

  StorageUploadTask uploadTask;

  FirebaseStorage storage;

  fb.StorageReference ref;

  Image pickedImage;

  fb.UploadTask _uploadTask;

  bool loadDing = false;

  uploadToFireBase(Uint8List imageFile) async {
    Random random = new Random();
    int randomNumber = random.nextInt(100000000) +10 ; //
    if(bytesFromPicker != null) {
      final filePath = randomNumber.toString();
      debugPrint(filePath);
      _uploadTask = fb
          .storage()
          .ref('icon')
          .child(filePath+'.png')
          .put(imageFile);
      _uploadTask.onStateChanged.listen((data){
        debugPrint('1');

      },onDone: (){
        _uploadTask.snapshot.ref.getDownloadURL().then((value){
          debugPrint('link : $value');
          debugPrint('name : $nameCateGory');
          try {
            categoryRepository.update(widget.data.docId, Category(
              value.toString(),
              nameCateGory,
            )).then((value2) {
              if(value2) {
                setState(() {
                  loadDing = false;
                  widget.onLoad();
                  Navigator.of(context).pop(true);
                });
              }
            });
          }catch (err) {
            debugPrint('error: $err');
          }
          fb.storage().ref('icon').child(
              widget.data.icon.replaceAll('https://firebasestorage.googleapis.com/v0/b/beautiful-care.appspot.com/o/icon%2F', '').split('?')[0]
          ).delete();
        }).catchError((error){
          debugPrint('error get link file: $error');
        });
      });
    } else {
      categoryRepository.update(widget.data.docId, Category(
        widget.data.icon,
        nameCateGory,
      )).then((value2) {
        if(value2) {
          setState(() {
            loadDing = false;
            widget.onLoad();
            Navigator.of(context).pop(true);
          });
        }
      });
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Container(
        width: 500,
        height: 500,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text("SỬA DANH MỤC", style: Theme.of(context).textTheme.subtitle,),
              padding: EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16
              ),
            ),
            Expanded(
              child: Container(
                child:  SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Tên danh mục',
                            labelText: 'Tên danh mục',
                            filled: true
                        ),
                        initialValue: widget.data.name ?? "" ,
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
                            ? Image.network(widget?.data?.icon, width: 120, height: 120,fit: BoxFit.fill,)
                            : Image.memory(bytesFromPicker, height: 120,width: 120,fit: BoxFit.fill,cacheWidth: 120,cacheHeight: 120,),
                      ),
                      SizedBox(height: 8,),
                      InkWell(
                        onTap: (){
                          uploadImage();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
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
                    onPressed: (){
                      if ( globalKey.currentState.validate()) {
                        globalKey.currentState.save();
                        setState(() {
                          loadDing = true;
                        });
                        uploadToFireBase(bytesFromPicker);
                      }
                    },
                    child: loadDing ? CircularProgressIndicator(backgroundColor: Colors.white,)
                        : Text('LƯU',style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(width: 8,),
                  FlatButton(
                    color: Colors.red,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('HUỶ',style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
              padding: EdgeInsets.all(16),
            )
          ],
        ),
      ),
    );
  }
}
