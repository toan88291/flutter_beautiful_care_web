//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/medical_examination.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//
//import '../dialog_update_medical_examination.dart';
//
//class RowMedicalSmallWidget extends StatefulWidget {
//
//  final MedicalExamination model;
//
//  final VoidCallback onLoad;
//
//  RowMedicalSmallWidget(this.model, this.onLoad);
//
//  @override
//  _RowMedicalSmallWidgetState createState() => _RowMedicalSmallWidgetState();
//}
//
//class _RowMedicalSmallWidgetState extends State<RowMedicalSmallWidget> {
//
//  PatientRepository patientRepository;
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository = Provider.of(context, listen: false);
//  }
//
//  Future<bool> deleteLoad(String docId) async {
//    await patientRepository.deleteMedical(docId);
//  }
//
//  void deleteRow(String docId) {
//    debugPrint('RowPatientSmallWidget: delete');
//    showDialogProgressLoading<bool>(context, deleteLoad(docId)).then((value){
//      widget.onLoad();
//      Navigator.of(context).pop();
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(16),
//      child: Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Mã bệnh án'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.model.idPatient),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Ngày khám'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text('${DateFormat.yMd().format(widget.model.time)}'),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Chuẩn đoán'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.model.diagnostic),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Điều trị'),
//                ),
//              ),
//              Expanded(child: Container(
//
//                padding: EdgeInsets.all(8),
//                child: Text(widget.model.treatment),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Bác sĩ'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.model.doctor),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Chú thích của bệnh nhân'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.model?.note_user ?? ''),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Thao tác'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    InkWell(
//                      onTap: (){
//                        _showUpdate(widget.model.docId);
//                      },
//                      child: Text(
//                        'Sửa',
//                        style: TextStyle(color: Colors.yellow),
//                      ),
//                    ),
//                    InkWell(
//                      onTap: (){
//                        _showInput(context).then((value) {
//
//                        });
//                      },
//                      child: Container(
//                        padding: EdgeInsets.all(12),
//                        child: Text(
//                          'Xoá',
//                          style: TextStyle(color: Colors.red),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<void> _showUpdate(String docId) async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(16)),
//          ),
//          child: DialogUpdateMedicalExamination(docId, widget.onLoad),
//        );
//      },
//    );
//  }
//
//  Future<bool> _showInput(context) async {
//    return showDialog<bool>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(16)),
//          ),
//          child: Container(
//            height: 200,
//            width: 200,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text('Bạn có chắc muốn xoá',style: TextStyle(color: Colors.red),),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    _buttonClick(
//                        'Không',
//                        Colors.redAccent,
//                            (){
//                          Navigator.of(context).pop();
//                        }
//                    ),
//                    _buttonClick(
//                        'Có',
//                        Colors.blue,
//                            (){
//                          debugPrint('id doc : ${widget.model.docId}');
//                          deleteRow(widget.model.docId);
//                        }
//                    )
//                  ],
//                )
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  Widget _buttonClick(String title,Color color, onclick) {
//    return InkWell(
//      onTap: onclick,
//      child: ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(12)),
//        child: Container(
//          alignment: Alignment.center,
//          width: 80,
//          height: 40,
//          decoration: BoxDecoration(
//            color: color,
//          ),
//          child: Text(title,style: TextStyle(color: Colors.white),),
//        ),
//      ),
//    );
//  }
//}