import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/models/category.dart';
import 'package:image_picker_web/image_picker_web.dart';


class UpdateCategoryWidget extends StatefulWidget {

  final Category data;

  UpdateCategoryWidget(this.data);

  @override
  _UpdateCategoryWidgetState createState() => _UpdateCategoryWidgetState();
}

class _UpdateCategoryWidgetState extends State<UpdateCategoryWidget> {
  static const TAG = 'UpdateCategoryWidget';

  GlobalKey<FormState> globalKey = GlobalKey();

  String nameCateGory;

  String icon;

  String name = '';

  String error;

  String imageLink;

  File _image;

  StorageReference storageReference;

  File uploadedImage;

  StorageUploadTask uploadTask;

  FirebaseStorage storage;

   fb.StorageReference ref;
   InputElement _uploadImage;

//  Future uploadToFireBase(File imageFile) async {
//
//
//    storage = FirebaseStorage(storageBucket:'gs://beautiful-care.appspot.com');
//
//    String path = "icon/${DateTime.now()}.png";
//
//    uploadTask = storage.ref().child(path).putFile(imageFile);
//
//
//    print('upload');
//
//    final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
//      print('EVENT ${event.type}');
//    });
//
//    await uploadTask.onComplete;
//    streamSubscription.cancel();

//  }

  fb.UploadTask _uploadTask;

  uploadToFirebase(File imageFile) async {
    final filePath = 'images/${DateTime.now()}.png';
    _uploadTask = fb
        .storage()
        .ref('icon')
        .child(filePath)
        .put(imageFile);
    _uploadTask.onStateChanged.listen((data) {
      debugPrint('$TAG $data');
    });
  }

  Future uploadImage() async {
//    Uint8List fromPicker = await ImagePickerWeb.getImage(asUint8List: true);
//    if (fromPicker != null) {
//      setState(() {
//        _image = File.fromRawPath(fromPicker);
//      });
//    }
//    uploadToFireBase(_image);
//    try {
//      ImageUploadApp();
//    } on fb.FirebaseJsNotLoadedException catch (e) {
//      print(e);
//    }


    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen(
          (changeEvent) {
        File file = uploadInput.files.first;
        final reader = FileReader();

        reader.readAsDataUrl(file);

        reader.onLoadEnd.listen(
          // After file finiesh reading and loading, it will be uploaded to firebase storage
              (loadEndEvent) async {
            uploadToFirebase(file);
          },
        );
        /*
        reader.onLoadEnd.listen(
              (loadEndEvent) async {
              try {
                debugPrint('image name : ${file.name.toString()}');
                ref = fb.storage().ref('icon');
                debugPrint('DEBUG---- $ref');
                _uploadImage = querySelector('#upload_image');
                _uploadImage.disabled = false;

                _uploadImage.onChange.listen((e) async {
                  e.preventDefault();

                  var customMetadata = {'location': 'Prague', 'owner': 'You'};
                  var uploadTask = ref.child(file.name).put(
                      file,
                      fb.UploadMetadata(
                          contentType: file.type, customMetadata: customMetadata));

                  uploadTask.onStateChanged.listen((e) {
                    querySelector('#message').text =
                    'Transfered ${e.bytesTransferred}/${e.totalBytes}...';
                  });

                  try {
                    var snapshot = await uploadTask.future;
                    var filePath = await snapshot.ref.getDownloadURL();
                    var image = ImageElement(src: filePath.toString());
                    document.body.append(image);
                    var metadata = snapshot.metadata.customMetadata;
                    querySelector('#message').text = 'Metadata: ${metadata.toString()}';
                  } catch (e) {
                    print(e);
                  }
                });

              } catch(error) {
                debugPrint('$TAG $error');
              }
            },
        );
        */
      },
    );
  }


  @override
  void initState() {
    super.initState();

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
                        child: imageLink == null
                            ? Image.network(widget.data.icon, width: 120, height: 120,)
                            : Image.network(imageLink, width: 120, height: 120,)
                      ),
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
                      )

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
                    onPressed: (){
                      if ( globalKey.currentState.validate()) {
                        globalKey.currentState.save();

                      }
                    }, child: Text('LƯU'),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text('HUỶ'),
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

//class ImageUploadApp {
//  final fb.StorageReference ref;
//  final InputElement _uploadImage;
//
//  ImageUploadApp()
//      : ref = fb.storage().ref('icon'),
//        _uploadImage = querySelector('#upload_image') {
//    _uploadImage.disabled = false;
//
//    _uploadImage.onChange.listen((e) async {
//      e.preventDefault();
//      var file = (e.target as FileUploadInputElement).files[0];
//
//      var customMetadata = {'location': 'Prague', 'owner': 'You'};
//      var uploadTask = ref.child(file.name).put(
//          file,
//          fb.UploadMetadata(
//              contentType: file.type, customMetadata: customMetadata));
//      uploadTask.onStateChanged.listen((e) {
//        querySelector('#message').text =
//        'Transfered ${e.bytesTransferred}/${e.totalBytes}...';
//      });
//
//      try {
//        var snapshot = await uploadTask.future;
//        var filePath = await snapshot.ref.getDownloadURL();
//        var image = ImageElement(src: filePath.toString());
//        document.body.append(image);
//        var metadata = snapshot.metadata.customMetadata;
//        querySelector('#message').text = 'Metadata: ${metadata.toString()}';
//      } catch (e) {
//        print(e);
//      }
//    });
//  }
//}