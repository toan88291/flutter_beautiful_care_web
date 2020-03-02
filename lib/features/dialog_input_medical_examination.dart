//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/medical_examination.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//
//import 'package:provider/provider.dart';
//
//class DialogInputMedicalExamination extends StatefulWidget {
//
//  final VoidCallback onLoad;
//
//  DialogInputMedicalExamination(this.onLoad);
//
//  @override
//  _DialogInputMedicalExaminationState createState() => _DialogInputMedicalExaminationState();
//}
//
//class _DialogInputMedicalExaminationState extends State<DialogInputMedicalExamination> {
//  static const TAG = 'DialogInputMedicalExamination';
//
//  GlobalKey<FormState> globalKey = GlobalKey();
//
//  bool checkCode = false;
//
//  //region string
//  String code;
//
//  String diagnostic;
//
//  String treatment;
//
//  String doctor;
//
//  List<String> errorPatient = [];
//  //endregion
//
//  PatientRepository patientRepository;
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    patientRepository = Provider.of<PatientRepository>(context, listen: false);
//  }
//
//  Future insert() async {
//    await patientRepository.insert(MedicalExamination(
//        code,
//        diagnostic,
//        doctor,
//        treatment,
//        DateTime.now(),
//        ""
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
//              child: Text("NHẬP THÔNG TIN BỆNH ÁN", style: Theme.of(context).textTheme.subtitle,),
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
//                        keyboardType: TextInputType.number,
//                        maxLength: 6,
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.confirmation_number),
//                            hintText: 'Mã bệnh án',
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
//                      errorPatient.isNotEmpty ? Text(
//                        errorPatient[0],
//                        style: TextStyle(color: Colors.redAccent),
//                      ) : Container(),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.assignment),
//                            hintText: 'Chuẩn đoán',
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
//                          diagnostic = value;
//                        },
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.opacity),
//                            hintText: 'Điều trị',
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
//                          treatment = value;
//                        },
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        decoration: InputDecoration(
//                            icon: Icon(Icons.account_circle),
//                            hintText: 'Bác sĩ',
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
//                          doctor = value;
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
//                        if(_isNumeric(code)) {
//                          patientRepository.checkPatient(code).then((value){
//                            if(value) {
//                              loadInsert();
//                            } else {
//                              setState(() {
//                                errorPatient.clear();
//                                errorPatient.add('Mã bệnh nhân không tồn tại');
//                              });
//                            }
//                          });
//                        } else {
//                          setState(() {
//                            errorPatient.clear();
//                            errorPatient.add('Mã bệnh nhân phải là số');
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
