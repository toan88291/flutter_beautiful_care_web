//
//import 'package:flutter/material.dart';
//import 'package:flutter_beautiful_care_web/data/models/patient.dart';
//import 'package:flutter_beautiful_care_web/data/patient_repository.dart';
//import 'package:flutter_beautiful_care_web/widget/show_dialog_loading.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//
//import '../dialog_update_patient_examination.dart';
//
//class RowPatientSmallWidget extends StatefulWidget {
//
//  final Patient data;
//
//  final VoidCallback onLoad;
//
//  RowPatientSmallWidget(this.data, this.onLoad);
//
//  @override
//  _RowPatientSmallWidgetState createState() => _RowPatientSmallWidgetState();
//}
//
//class _RowPatientSmallWidgetState extends State<RowPatientSmallWidget> {
//
//  PatientRepository patientRepository;
//
//
//  Future<bool> deleteLoad(String docId) async {
//    await patientRepository.deletePatient(docId);
//  }
//
//  void deleteRow(String docId) {
//    showDialogProgressLoading<bool>(context, deleteLoad(docId)).then((value){
//      Navigator.of(context).pop();
//      widget.onLoad();
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    patientRepository = Provider.of(context, listen: false);
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
//                  child: Text('Tên bệnh nhân'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.name),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Mã bệnh nhân'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.docId),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Địa chỉ'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.address),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Email'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.email),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Giới tính'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.gender == 0 ? 'Nam' : 'Nữ'),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Điện thoại'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.phone),
//              ),),
//            ],
//          ),
//          Divider(height: 0.3,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  padding: EdgeInsets.all(8),
//                  child: Text('Bảo hiểm'),
//                ),
//              ),
//              Expanded(child: Container(
//                padding: EdgeInsets.all(8),
//                child: Text(widget.data.refer),
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
//                        _showUpdate();
//                      },
//                      child: Text(
//                        'Sửa',
//                        style: TextStyle(color: Colors.yellow),
//                      ),
//                    ),
//                    InkWell(
//                      onTap: (){
//                        _showDelete();
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
//  Future<void> _showUpdate() async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(16)),
//          ),
//          child: DialogUpdatePatientExamination(widget.data.docId, widget.onLoad),
//        );
//      },
//    );
//  }
//
//  Future<bool> _showDelete() async {
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
//                        Colors.redAccent, (){
//                      Navigator.of(context).pop();
//                    }
//                    ),
//                    _buttonClick(
//                        'Có',
//                        Colors.blue, (){
//                      deleteRow(widget.data.docId);
//                    }
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