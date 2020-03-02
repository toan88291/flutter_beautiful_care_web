//
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/patient.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//
//class DialogInputPatientExamination extends StatefulWidget {
//
//  final VoidCallback onLoad;
//
//  DialogInputPatientExamination(this.onLoad);
//
//  @override
//  _DialogInputPatientExaminationState createState() => _DialogInputPatientExaminationState();
//}
//
//class _DialogInputPatientExaminationState extends State<DialogInputPatientExamination> {
//
//  GlobalKey<FormState> globalKey = GlobalKey();
//
//  PatientRepository patientRepository;
//
//  //region string
//
//  String code;
//
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
//  //endregion
//
//  final format = DateFormat("yyyy/MM/dd");
//
//  List<String> errorCode = [];
//
//  List<String> errorPhone = [];
//
//  List<String> errorEmail = [];
//
//  SingingCharacter _character = SingingCharacter.male;
//
//  // region TextEditingController
//  TextEditingController tecPhone;
//
//  TextEditingController tecEmail;
//
//  TextEditingController tecCode;
//
//  TextEditingController tecName;
//
//  TextEditingController tecAddress;
//
//  TextEditingController tecBirth;
//
//  TextEditingController tecRefer;
//  //endregion
//
//  Future insert() async {
//    await patientRepository.insertPatient(code,Patient(
//      address,
//      email,
//      gender,
//      name,
//      phone,
//      refer
//    ));
//  }
//
//  void loadInsert() {
//    showDialogProgressLoading(context, insert()).then((value){
//      widget.onLoad();
//      Navigator.of(context).pop();
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    tecPhone = TextEditingController();
//    tecEmail = TextEditingController();
//    tecCode = TextEditingController();
//    tecName = TextEditingController();
//    tecAddress = TextEditingController();
//    tecBirth = TextEditingController();
//    tecRefer = TextEditingController();
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    gender = 0;
//    patientRepository = Provider.of<PatientRepository>(context, listen: false);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    tecPhone.dispose();
//    tecEmail.dispose();
//    tecCode.dispose();
//    tecName.dispose();
//    tecAddress.dispose();
//    tecBirth.dispose();
//    tecRefer.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: globalKey,
//      child: Container(
//        width: 500,
//        height: 500,
//        child: Column(
//          children: <Widget>[
//            Container(
//              alignment: Alignment.centerLeft,
//              child: Text("NHẬP THÔNG TIN BỆNH NHÂN", style: Theme.of(context).textTheme.subtitle,),
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
//                        maxLength: 6,
//                        controller: tecCode,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.account_circle),
//                            hintText: 'Mã bệnh nhân',
//                            filled: true
//                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Không được để trống !';
//                          } else {
//                            return null;
//                          }
//                        },
//                        onSaved: (value) {
//                          code = value;
//                        },
//                      ),
//                      Divider(
//                        height: 4,
//                        color: Colors.transparent,
//                      ),
//                      errorCode.isNotEmpty ? Text(
//                        errorCode[0],
//                        style: TextStyle(color: Colors.redAccent),
//                      ) : Container(),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        controller: tecName,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.account_circle),
//                            hintText: 'Tên bệnh nhân',
//                            filled: true
//                        ),
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
//                        controller: tecAddress,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.map),
//                            hintText: 'Địa chỉ',
//                            filled: true
//                        ),
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
//                      Container(
//                        padding: EdgeInsets.only(left: 38),
//                        child: DateTimeField(
//                          format: format,
//                          controller: tecBirth,
//                          initialValue: birthday ?? null,
//                          decoration: InputDecoration(
//                            hintText: 'Ngày sinh'
//                          ),
//                          onShowPicker: (context, currentValue) {
//                            return showDatePicker(
//                                context: context,
//                                firstDate: DateTime(1900),
//                                initialDate: currentValue ?? DateTime.now(),
//                                lastDate: DateTime.now()
//                            );
//                          },
//                          validator: (value) {
//                            if (value == null) {
//                              return 'Không được để trống !';
//                            } else {
//                              return null;
//                            }
//                          },
//                          onSaved: (value) {
//                            birthday = value;
//                          },
//                        ),
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        keyboardType: TextInputType.emailAddress,
//                        controller: tecEmail,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.email),
//                            hintText: 'Email',
//                            filled: true
//                        ),
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
//                            child: Icon(Icons.supervised_user_circle),
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
//                        controller: tecPhone,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.phone),
//                            hintText: 'Điện thoại',
//                            filled: true
//                        ),
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
//                        controller: tecRefer,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.account_balance),
//                            hintText: 'Bảo hiểm',
//                            filled: true
//                        ),
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
//                        errorCode.clear();
//                        errorEmail.clear();
//                        if (_isNumeric(code) && code.length == 6) {
//                          if( _isNumeric(phone) && phone.length == 10) {
//                            if(email.contains('@')) {
//                              loadInsert();
//                            } else {
//                              setState(() {
//                                errorEmail.add('Phải nhập đúng định dạng email');
//                              });
//                            }
//                          } else {
//                            setState(() {
//                              errorPhone.add('Phải nhập dạng 10 chữ số');
//                            });
//                          }
//                        } else {
//                          setState(() {
//                            errorCode.add('Phải nhập dạng 6 chữ số');
//                          });
//                        }
//                      }
//                    }, child: Text('THÊM'),
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
//
//enum SingingCharacter { male, female }
