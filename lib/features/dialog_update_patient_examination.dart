//
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/patient.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//
//class DialogUpdatePatientExamination extends StatefulWidget {
//
//  final String docId;
//
//  final VoidCallback onLoad;
//
//  DialogUpdatePatientExamination(this.docId, this.onLoad);
//
//  @override
//  _DialogUpdatePatientExaminationState createState() => _DialogUpdatePatientExaminationState();
//}
//
//class _DialogUpdatePatientExaminationState extends State<DialogUpdatePatientExamination> {
//
//  GlobalKey<FormState> globalKey = GlobalKey();
//
//  bool checkCode = false;
//
//  final format = DateFormat("yyyy/MM/dd");
//
//  SingingCharacter _character = SingingCharacter.male;
//
//  TextEditingController textEditingController;
//
//  //region patient
//  String address;
//
//  DateTime birthday;
//
//  String email;
//
//  int gender;
//
//  String name;
//
//  String phone;
//
//  String refer;
//
//  //endregion
//
//  List<String> errorPhone = [];
//
//  List<String> errorEmail = [];
//
//  Patient data;
//
//  PatientRepository patientRepository;
//
//  Future update() async {
//    Map<String, dynamic> map;
//    map = {
//      'address' : address,
//      'birthday' : birthday,
//      'email' : email,
//      'gender' : gender,
//      'name' : name,
//      'phone' : phone,
//      'refer' : refer,
//    };
//    await patientRepository.updatePatient(data.docId, map);
//  }
//
//  void loadUpdate() {
//    showDialogProgressLoading(context, update()).then((value){
//      widget.onLoad();
//      Navigator.pop(context);
//      textEditingController.dispose();
//    });
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    patientRepository = Provider.of(context,listen: false);
//    patientRepository.getPatient(widget.docId).then((value){
//      setState(() {
//        data = value;
//        data.gender == 0 ? _character = SingingCharacter.male : _character = SingingCharacter.female;
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return data != null ? Form(
//      key: globalKey,
//      child: Container(
//        width: 500,
//        height: 500,
//        child: Column(
//          children: <Widget>[
//            Container(
//              alignment: Alignment.centerLeft,
//              child: Text("SỬA THÔNG TIN BỆNH NHÂN", style: Theme.of(context).textTheme.subtitle,),
//              padding: EdgeInsets.symmetric(
//                  vertical: 32,
//                  horizontal: 16
//              ),
//            ),
//            Expanded(
//              child: Container(
//                child:  SingleChildScrollView(
//                  child: Column(
//                    children: <Widget>[
//                      TextFormField(
//                        decoration: InputDecoration(
//                            hintText: 'Tên bệnh nhân',
//                            labelText: 'Tên bệnh nhân',
//                            filled: true
//                        ),
//                        initialValue: data?.name ?? "" ,
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Không được để trống !';
//                          } else {
//                            return null;
//                          }
//                        },
//                        onSaved: (value) {
//                          name = value;
//                        },
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        decoration: InputDecoration(
//                            hintText: 'Địa chỉ',
//                            labelText: 'Địa chỉ',
//                            filled: true
//                        ),
//                        initialValue: data?.address ?? "",
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Không được để trống !';
//                          } else {
//                            return null;
//                          }
//                        },
//                        onSaved: (value) {
//                          address = value;
//                        },
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        keyboardType: TextInputType.emailAddress,
//                        decoration: InputDecoration(
//                            hintText: 'Email',
//                            labelText: 'Email',
//                            filled: true
//                        ),
//                        initialValue: data?.email ?? "",
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Không được để trống !';
//                          } else {
//                            return null;
//                          }
//                        },
//                        onSaved: (value) {
//                          email = value;
//                        },
//                      ),
//                      Divider(
//                        height: 4,
//                        color: Colors.transparent,
//                      ),
//                      errorEmail.isNotEmpty ? Text(
//                        errorEmail[0],
//                        style: TextStyle(color: Colors.redAccent),
//                      ) : Container(),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.only(right: 12),
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Text('Nam'),
//                              Radio(
//                                value: SingingCharacter.male,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() {
//                                    _character = value;
//                                    gender = 0;
//                                  });
//                                },
//                              )
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Text('Nữ'),
//                              Radio(
//                                value: SingingCharacter.female,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() {
//                                    _character = value;
//                                    gender = 1;
//                                  });
//                                },
//                              ),
//                            ],
//                          )
//                        ],
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        maxLength: 10,
//                        decoration: InputDecoration(
//                            hintText: 'Điện thoại',
//                            labelText: 'Điện thoại',
//                            filled: true
//                        ),
//                        initialValue: data?.phone ?? "",
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Không được để trống !';
//                          } else {
//                            return null;
//                          }
//                        },
//                        onSaved: (value) {
//                          phone = value;
//                        },
//                      ),
//                      Divider(
//                        height: 4,
//                        color: Colors.transparent,
//                      ),
//                      errorPhone.isNotEmpty ? Text(
//                        errorPhone[0],
//                        style: TextStyle(color: Colors.redAccent),
//                      ) : Container(),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        decoration: InputDecoration(
//                            hintText: 'Bảo hiểm',
//                            labelText: 'Bảo hiểm',
//                            filled: true
//                        ),
//                        initialValue: data?.refer ?? "",
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Không được để trống !';
//                          } else {
//                            return null;
//                          }
//                        },
//                        onSaved: (value) {
//                          refer = value;
//                        },
//                      ),
//                    ],
//                  ),
//                ),
//                padding: EdgeInsets.all(16),
//              ),
//            ),
//            Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  FlatButton(
//                    onPressed: (){
//                      if ( globalKey.currentState.validate()) {
//                        globalKey.currentState.save();
//                        errorPhone.clear();
//                        errorEmail.clear();
//                        if( _isNumeric(phone) && phone.length == 10) {
//                          if(email.contains('@')) {
//                            loadUpdate();
//                          } else {
//                            setState((){
//                              errorEmail.add('Phải nhập đúng định dạng email');
//                            });
//                          }
//                        } else {
//                          setState(() {
//                            errorPhone.add('Phải nhập dạng 10 chữ số');
//                          });
//                        }
//                      }
//                    }, child: Text('LƯU'),
//                  ),
//                  FlatButton(
//                    onPressed: (){
//                      Navigator.of(context).pop();
//                    }, child: Text('HUỶ'),
//                  )
//                ],
//              ),
//              padding: EdgeInsets.all(16),
//            )
//          ],
//        ),
//      ),
//    ) : Container(
//      width: 48,
//      height: 48,
//      color: Colors.transparent,
//      alignment: Alignment.center,
//      child: CircularProgressIndicator(),
//    );
//  }
//
//  bool _isNumeric(String str) {
//    if(str == null) {
//      return false;
//    }
//    return double.tryParse(str) != null;
//  }
//
//}
//enum SingingCharacter { male, female }
