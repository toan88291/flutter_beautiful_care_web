//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/medical_examination.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:provider/provider.dart';
//
//class DialogUpdateMedicalExamination extends StatefulWidget {
//
//  final String docId;
//
//  final VoidCallback onLoad;
//
//  DialogUpdateMedicalExamination(this.docId, this.onLoad);
//
//  @override
//  _DialogUpdateMedicalExaminationState createState() => _DialogUpdateMedicalExaminationState();
//}
//
//class _DialogUpdateMedicalExaminationState extends State<DialogUpdateMedicalExamination> {
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
//  //endregion
//
//  MedicalExamination data;
//
//  PatientRepository patientRepository;
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    patientRepository = Provider.of<PatientRepository>(context, listen: false);
//    patientRepository.getMedical(widget.docId).then((value){
//      setState(() {
//        data = value;
//        debugPrint("doctor : ${data.doctor}");
//        debugPrint("idpatient : ${data.idPatient}");
//        debugPrint("id : ${data.docId}");
//        debugPrint("note user : ${data.note_user}");
//        debugPrint("time : ${data.time}");
//        debugPrint("treatment : ${data.treatment}");
//      });
//    });
//  }
//
//  Future update() async {
//    Map<String, dynamic> map;
//    map = {
//      'diagnostic' : diagnostic,
//      'doctor' : doctor,
//      'id_patient' : data.idPatient,
//      'note_user' : data.note_user,
//      'time' : data.time,
//      'treatment' : treatment,
//    };
//    await patientRepository.update(data.docId, map);
//  }
//
//  void loadUpdate() {
//    showDialogProgressLoading(context, update()).then((value){
//      widget.onLoad();
//      Navigator.of(context).pop();
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
//              child: Text("SỬA THÔNG TIN BỆNH ÁN", style: Theme.of(context).textTheme.subtitle,),
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
//                        initialValue: data?.idPatient ?? 'a',
//                        decoration: InputDecoration(
//                            labelText: 'Mã bệnh án',
//                            hintText: 'Mã bệnh án',
//                            filled: true
//                        ),
//                        readOnly: true,
//                      ),
//                      Divider(
//                        height: 32,
//                        color: Colors.transparent,
//                      ),
//                      TextFormField(
//                        initialValue: data?.diagnostic ?? '',
//                        decoration: InputDecoration(
//                            labelText: 'Chuẩn đoán',
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
//                        initialValue: data?.treatment ?? '',
//                        decoration: InputDecoration(
//                            hintText: 'Điều trị',
//                            labelText: 'Điều trị',
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
//                        initialValue: data?.doctor ?? '',
//                        decoration: InputDecoration(
//                            hintText: 'Bác sĩ',
//                            labelText: 'Bác sĩ',
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
//                        loadUpdate();
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
//        width: 48,
//        height: 48,
//        color: Colors.transparent,
//        alignment: Alignment.center,
//        child: CircularProgressIndicator(),
//    );
//  }
//
//
//}